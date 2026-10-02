import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

/// Minimal backend contract so a second AI backend (e.g. a self-hosted
/// Ollama instance over LAN/Tailscale) can be swapped in later without
/// touching any calling code — only [GeminiService]'s internal `_backend`
/// would need to change.
abstract class AiBackend {
  Future<String?> generateText(String prompt);
  Future<Map<String, dynamic>?> generateJson(String prompt, {Uint8List? imageBytes, String? imageMimeType});
}

/// Wraps both the text and vision endpoints of the Gemini API behind one
/// interface. Every AI call in the app (meal photo estimate, weekly
/// review) goes through this single service.
///
/// - API key is read from the bundled `.env` file (`GEMINI_API_KEY`),
///   never hardcoded.
/// - Retries with exponential backoff on HTTP 429 (rate limit).
/// - Fails silently (returns null) on any error — offline, no key, bad
///   response, whatever — so AI features degrade gracefully instead of
///   throwing in the middle of a screen. Callers should treat a null
///   result as "fall back to fully manual", not as an error to surface.
class GeminiService {
  GeminiService._() : _backend = _GeminiBackend();
  static final GeminiService instance = GeminiService._();

  final AiBackend _backend;

  bool get isConfigured {
    final key = dotenv.env['GEMINI_API_KEY'];
    return key != null && key.trim().isNotEmpty;
  }

  /// Generates a short piece of text (used for the weekly coaching review).
  /// Returns null if the API key is missing, there's no network, or the
  /// call otherwise fails after retries.
  Future<String?> generateText(String prompt) async {
    if (!isConfigured) return null;
    try {
      return await _backend.generateText(prompt);
    } catch (_) {
      return null;
    }
  }

  /// Sends a meal photo to the vision-capable model and asks for a rough
  /// calorie/macro estimate as structured JSON:
  /// `{ "description": str, "calories": num, "protein_g": num, "carbs_g": num, "fat_g": num }`
  /// Returns null on any failure (offline, no key, malformed response) —
  /// the caller should fall back to a fully manual entry in that case.
  Future<Map<String, dynamic>?> estimateMealFromPhoto(Uint8List imageBytes) async {
    if (!isConfigured) return null;
    const prompt = '''
You are a nutrition estimation assistant. Look at this meal photo and give a
rough estimate. Respond with ONLY a single JSON object, no markdown fences,
no commentary, in exactly this shape:
{"description": "short description of what's on the plate", "calories": <number>, "protein_g": <number>, "carbs_g": <number>, "fat_g": <number>}
If you can't identify the food, make a reasonable generic estimate rather
than refusing — this is a rough starting point the person will adjust
manually, not a medical or precise measurement.''';
    try {
      return await _backend.generateJson(prompt, imageBytes: imageBytes, imageMimeType: 'image/jpeg');
    } catch (_) {
      return null;
    }
  }
}

class _GeminiBackend implements AiBackend {
  // Free-tier flash model — cheap/fast, good enough for rough estimates
  // and short coaching text. Swap here if Anthropic... er, Google renames
  // or deprecates it.
  static const _model = 'gemini-2.5-flash';
  static const _baseUrl = 'https://generativelanguage.googleapis.com/v1beta/models';
  static const _maxRetries = 3;

  String get _apiKey => dotenv.env['GEMINI_API_KEY'] ?? '';

  @override
  Future<String?> generateText(String prompt) async {
    final body = {
      'contents': [
        {
          'parts': [
            {'text': prompt}
          ]
        }
      ],
    };
    final json = await _postWithRetry(body);
    return _extractText(json);
  }

  @override
  Future<Map<String, dynamic>?> generateJson(String prompt, {Uint8List? imageBytes, String? imageMimeType}) async {
    final parts = <Map<String, dynamic>>[
      {'text': prompt},
    ];
    if (imageBytes != null) {
      parts.add({
        'inline_data': {
          'mime_type': imageMimeType ?? 'image/jpeg',
          'data': base64Encode(imageBytes),
        },
      });
    }
    final body = {
      'contents': [
        {'parts': parts}
      ],
      'generationConfig': {'response_mime_type': 'application/json'},
    };
    final json = await _postWithRetry(body);
    final text = _extractText(json);
    if (text == null) return null;
    try {
      final decoded = jsonDecode(text);
      return decoded is Map<String, dynamic> ? decoded : null;
    } catch (_) {
      return null;
    }
  }

  Future<Map<String, dynamic>?> _postWithRetry(Map<String, dynamic> body) async {
    var attempt = 0;
    var delay = const Duration(milliseconds: 800);
    while (attempt < _maxRetries) {
      attempt++;
      http.Response response;
      try {
        response = await http
            .post(
              Uri.parse('$_baseUrl/$_model:generateContent?key=$_apiKey'),
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode(body),
            )
            .timeout(const Duration(seconds: 30));
      } catch (_) {
        // Network unreachable — no point retrying immediately.
        return null;
      }

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      }
      if (response.statusCode == 429 && attempt < _maxRetries) {
        await Future.delayed(delay);
        delay *= 2;
        continue;
      }
      return null; // 4xx/5xx that isn't a retryable rate limit
    }
    return null;
  }

  String? _extractText(Map<String, dynamic>? json) {
    if (json == null) return null;
    try {
      final candidates = json['candidates'] as List?;
      if (candidates == null || candidates.isEmpty) return null;
      final parts = candidates.first['content']?['parts'] as List?;
      if (parts == null || parts.isEmpty) return null;
      final text = parts.first['text'] as String?;
      return text?.trim();
    } catch (_) {
      return null;
    }
  }
}
