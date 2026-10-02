import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'core/app_shell.dart';
import 'core/theme/app_theme_builder.dart';
import 'core/theme/palette_scope.dart';
import 'core/theme/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones(); // required by device_calendar's TZDateTime
  // Loads GEMINI_API_KEY for GeminiService. If the .env file is missing or
  // empty this fails silently — AI features (photo meal estimate, weekly
  // review) just report themselves as unconfigured rather than the app
  // crashing on a personal, optional feature.
  try {
    await dotenv.load(fileName: '.env');
  } catch (_) {
    // No .env bundled or unreadable — AI features stay off, everything
    // else in the app works exactly the same.
  }
  runApp(const ProviderScope(child: TheSystemApp()));
}

class TheSystemApp extends ConsumerWidget {
  const TheSystemApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = ref.watch(currentPaletteProvider);

    return PaletteScope(
      palette: palette,
      child: MaterialApp(
        title: 'The System',
        debugShowCheckedModeBanner: false,
        theme: AppThemeBuilder.build(palette),
        home: const AppShell(),
      ),
    );
  }
}
