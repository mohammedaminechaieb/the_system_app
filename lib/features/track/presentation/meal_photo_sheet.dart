import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../../core/ai/gemini_service.dart';
import '../../../core/providers/core_providers.dart';
import '../../../core/theme/app_palette.dart';
import '../../../core/widgets/entry_toast.dart';
import '../../../core/widgets/picker_field.dart';
import '../../../core/widgets/shared_widgets.dart';
import '../data/track_providers.dart';

const _kMealTypesForPhoto = ['Breakfast', 'Lunch', 'Dinner', 'Snack'];

/// Opens the photo-based meal logging flow: pick/take a photo, get a rough
/// Gemini vision estimate, let the person adjust every number before
/// saving. Falls back to a plain manual entry (no photo, no AI) if
/// there's no network, no API key configured, or the call fails —
/// nothing here ever blocks logging a meal.
Future<void> showMealPhotoSheet(BuildContext context, WidgetRef ref) async {
  final picker = ImagePicker();
  final source = await showModalBottomSheet<ImageSource>(
    context: context,
    builder: (sheetContext) => SafeArea(
      child: Wrap(children: [
        ListTile(leading: const Icon(Icons.photo_camera_outlined), title: const Text('Take a photo'), onTap: () => Navigator.of(sheetContext).pop(ImageSource.camera)),
        ListTile(leading: const Icon(Icons.photo_library_outlined), title: const Text('Choose from gallery'), onTap: () => Navigator.of(sheetContext).pop(ImageSource.gallery)),
      ]),
    ),
  );
  if (source == null || !context.mounted) return;

  XFile? picked;
  try {
    picked = await picker.pickImage(source: source, maxWidth: 1600, imageQuality: 82);
  } catch (_) {
    picked = null;
  }
  if (picked == null || !context.mounted) return;

  // Keep a copy in the app's own documents dir — the picker's temp file
  // isn't guaranteed to stick around.
  String savedPath;
  try {
    final dir = await getApplicationDocumentsDirectory();
    final mealsDir = Directory(p.join(dir.path, 'meal_photos'));
    if (!await mealsDir.exists()) await mealsDir.create(recursive: true);
    final dest = p.join(mealsDir.path, '${DateTime.now().millisecondsSinceEpoch}.jpg');
    await File(picked.path).copy(dest);
    savedPath = dest;
  } catch (_) {
    savedPath = picked.path; // best effort — still usable for this session
  }

  if (!context.mounted) return;
  final saved = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    builder: (sheetContext) => _MealPhotoReviewSheet(photoPath: savedPath),
  );
  // Toast from the caller's context — the sheet's own context is already
  // gone once it has popped.
  if (saved == true && context.mounted) {
    showEntryAddedToast(context, message: 'Meal logged', icon: Icons.restaurant);
  } else if (saved != true && savedPath != picked.path) {
    // Cancelled — don't leave an orphaned copy in app storage.
    try {
      await File(savedPath).delete();
    } catch (_) {}
  }
}

/// Best guess at which meal a photo taken right now belongs to.
String defaultMealForNow([DateTime? now]) {
  final h = (now ?? DateTime.now()).hour;
  if (h >= 4 && h < 11) return 'Breakfast';
  if (h >= 11 && h < 15) return 'Lunch';
  if (h >= 17 && h < 22) return 'Dinner';
  return 'Snack';
}

class _MealPhotoReviewSheet extends ConsumerStatefulWidget {
  final String photoPath;
  const _MealPhotoReviewSheet({required this.photoPath});

  @override
  ConsumerState<_MealPhotoReviewSheet> createState() => _MealPhotoReviewSheetState();
}

class _MealPhotoReviewSheetState extends ConsumerState<_MealPhotoReviewSheet> {
  bool _loadingEstimate = true;
  bool _saving = false;
  bool _aiEstimated = false;
  String? _meal = defaultMealForNow();
  late final TextEditingController _descController;
  late final TextEditingController _calController;
  late final TextEditingController _proteinController;
  late final TextEditingController _carbController;
  late final TextEditingController _fatController;

  @override
  void initState() {
    super.initState();
    _descController = TextEditingController();
    _calController = TextEditingController();
    _proteinController = TextEditingController();
    _carbController = TextEditingController();
    _fatController = TextEditingController();
    _runEstimate();
  }

  Future<void> _runEstimate() async {
    if (!GeminiService.instance.isConfigured) {
      setState(() => _loadingEstimate = false);
      return;
    }
    try {
      final bytes = await File(widget.photoPath).readAsBytes();
      final estimate = await GeminiService.instance.estimateMealFromPhoto(bytes);
      if (!mounted) return;
      if (estimate != null) {
        setState(() {
          _descController.text = (estimate['description'] as String?) ?? '';
          _calController.text = _numToText(estimate['calories']);
          _proteinController.text = _numToText(estimate['protein_g']);
          _carbController.text = _numToText(estimate['carbs_g']);
          _fatController.text = _numToText(estimate['fat_g']);
          _aiEstimated = true;
        });
      }
    } catch (_) {
      // Falls through to fully manual — nothing to show, no error banner.
    } finally {
      if (mounted) setState(() => _loadingEstimate = false);
    }
  }

  String _numToText(dynamic v) {
    if (v == null) return '';
    if (v is num) return v.round().toString();
    return v.toString();
  }

  double? _parse(TextEditingController c) => c.text.trim().isEmpty ? null : double.tryParse(c.text.trim());

  @override
  void dispose() {
    _descController.dispose();
    _calController.dispose();
    _proteinController.dispose();
    _carbController.dispose();
    _fatController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_meal == null || _descController.text.trim().isEmpty) return;
    setState(() => _saving = true);
    final db = ref.read(databaseProvider);
    final todayKey = ref.read(todayKeyProvider);
    await addNutritionLog(
      db,
      date: todayKey,
      meal: _meal!,
      description: _descController.text.trim(),
      calories: _parse(_calController),
      estProteinG: _parse(_proteinController),
      estCarbsG: _parse(_carbController),
      estFatG: _parse(_fatController),
      photoPath: widget.photoPath,
      aiEstimated: _aiEstimated,
    );
    if (!mounted) return;
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    final canSave = !_saving && _meal != null && _descController.text.trim().isNotEmpty;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 14, 18, 18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(p.cardRadius),
                child: Image.file(
                  File(widget.photoPath),
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(height: 160, color: p.primarySoft, alignment: Alignment.center, child: Icon(Icons.image_not_supported_outlined, color: p.primary)),
                ),
              ),
              const SizedBox(height: 14),
              if (_loadingEstimate)
                const Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Row(children: [SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)), SizedBox(width: 10), Text('Estimating from photo…')]))
              else if (_aiEstimated)
                const CalloutBox(icon: Icons.auto_awesome_outlined, text: 'Rough AI estimate below — adjust anything before saving.')
              else if (!GeminiService.instance.isConfigured)
                const CalloutBox(icon: Icons.info_outline, text: 'AI estimate unavailable (no API key configured) — enter details manually.')
              else
                const CalloutBox(icon: Icons.wifi_off, text: "Couldn't reach the AI estimator — enter details manually."),
              const SizedBox(height: 14),
              PickerField<String>(
                label: 'Meal',
                value: _meal,
                leadingIcon: Icons.schedule,
                options: [for (final m in _kMealTypesForPhoto) PickerOption(value: m, label: m)],
                onChanged: (v) => setState(() => _meal = v),
              ),
              const SizedBox(height: 10),
              TextField(controller: _descController, onChanged: (_) => setState(() {}), decoration: const InputDecoration(labelText: 'What is it?')),
              const SizedBox(height: 10),
              Row(children: [
                Expanded(child: TextField(controller: _calController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Calories'))),
                const SizedBox(width: 8),
                Expanded(child: TextField(controller: _proteinController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Protein (g)'))),
              ]),
              const SizedBox(height: 10),
              Row(children: [
                Expanded(child: TextField(controller: _carbController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Carbs (g)'))),
                const SizedBox(width: 8),
                Expanded(child: TextField(controller: _fatController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Fat (g)'))),
              ]),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: canSave ? _save : null,
                  child: Text(_saving ? 'Saving…' : 'Save meal'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
