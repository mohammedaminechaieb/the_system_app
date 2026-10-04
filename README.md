# The System — Flutter App

A personal lifestyle, fitness, habits, and time-management app. Local-only
(SQLite via drift), Riverpod state management, soft-lock daily gate with a
streak/penalty system, a full 10-chapter Atomic Habits reader, and
season-aware (summer/winter) training and nutrition guidance.

## What changed in this revision

- **Four switchable themes** (Settings → Appearance): Midnight (dark, bold), Editorial (cream/terracotta), Minimal (soft neutral), Nature (deep green). Every screen reads colors through `AppPalette.of(context)` — nothing is hardcoded — so switching is instant and total.
- **Visual restructuring**: Reference (martial arts), Nutrition, and Sports now use image cards, hero headers, and horizontal scroll galleries instead of paragraph blocks. Network images (Unsplash) with a themed icon fallback if offline.
- **Picker-based entry everywhere**: exercise type, sleep times, meal choices, hobby categories, ratings — all tap-to-select bottom sheets or chip/slider controls. Free-text typing is gone except where genuinely open-ended.
- **Gate screen rebuilt**: no disabled dead-end button. The bottom action is always tappable — either "All set — continue" or "Skip for now · X/Y done" — so there's no state where nothing responds.

## Before running

`flutter analyze` is clean and `flutter test` passes. The generated drift
code (`app_database.g.dart`) is checked in; re-run `build_runner` (step 4)
only after changing a table in `app_database.dart`.

**Gemini API key (optional).** Put your key in `.env` as
`GEMINI_API_KEY=...` to enable photo meal estimates and the weekly AI
review. `.env` is committed with an empty value because it must exist as a
bundled asset — after adding your key, run
`git update-index --skip-worktree .env` so it never gets committed. Note
that a key bundled into an APK can be extracted from it, so only use a
free-tier key you are comfortable with that risk for.

## 1. Prerequisites

- Flutter SDK 3.19+ (Dart 3.3+) installed and on your PATH — verify with `flutter doctor`
- Android Studio (or just the Android SDK + a device/emulator) for Android
- A physical Android phone with USB debugging enabled, or an emulator

## 2. Initialize the project

If you're starting from just these files (no `.git`, no platform folders
beyond the `android/` overrides included here), run this once from the
project root to let Flutter regenerate the full platform scaffolding
(iOS/Android/etc. build files) around your `lib/` and `pubspec.yaml`:

```bash
flutter create --org com.thesystem --project-name the_system .
```

This is safe to run even though `android/app/src/main/AndroidManifest.xml`
and `android/app/build.gradle.kts` already exist in this project — `flutter
create` will not overwrite files that already differ meaningfully, but if it
prompts to overwrite either of those two specific files, say **no**, since
the versions included here already have the required permissions
(`INTERNET`) and `minSdk = 21` (required by `sqlite3_flutter_libs`).

## 3. Install dependencies

```bash
flutter pub get
```

## 4. Generate drift's database code

The database schema in `lib/core/database/app_database.dart` uses
`part 'app_database.g.dart';` — the generated file is checked in, so this
step is only needed after schema changes:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Re-run this command any time you change a table definition in
`app_database.dart`.

## 5. Run it

```bash
flutter devices        # confirm your phone/emulator is detected
flutter run             # builds and installs in debug mode
```

For a release build to actually install permanently on your phone:

```bash
flutter build apk --release
# APK will be at build/app/outputs/flutter-apk/app-release.apk
# Copy it to your phone and install it (enable "install unknown apps" for
# whichever app you use to open the file, e.g. your file manager).
```

## 6. Checks

```bash
flutter analyze   # static analysis — should report no issues
flutter test      # unit + in-memory database tests (test/)
```

## Project structure

```
lib/
  core/
    app_shell.dart          — root navigation: gate → bottom-nav shell
    database/                — drift schema + connection
    providers/                — season, today's date, streak/penalty engine
    theme/                    — colors, text styles (paper/moss/rust palette)
    widgets/                  — shared reusable UI (cards, pills, accordions)
  features/
    gate/                     — the soft-lock morning check-in screen
    today/                    — home screen: plan, habits, quick log
    track/                    — exercise/sleep/weight/learning/martial/hobby/nutrition logging
    calendar/                 — weekly/hourly/monthly views, season-aware
    dashboard/                — weekly score, streak stats, review log
    atomic_habits/             — the 10-chapter reader (list + paginated reader)
    nutrition/                 — diet reference (not logging — see track/)
    sports/                    — strength/cardio reference, season-aware
    reference/                 — martial arts, hobbies, getting-started, priorities
    settings/                  — season toggle, streak info, about
  main.dart
```

## The "forced adherence" mechanics, explained

- **Soft-lock gate**: on each app open, you land on a check-in screen (energy
  level + core habits) before the rest of the app. It always has a visible
  "skip for now" escape hatch — this is a *soft* lock by design — but skipping
  doesn't stop the streak/penalty system from noticing an incomplete day.
- **Streak + points**: each core habit ticked awards points immediately;
  completing all of them for the day grows your streak and awards a bonus.
- **Penalty + streak-freeze**: if a full day passes with the gate never
  completed, a streak-freeze is consumed automatically if you have one
  available (max 2, one earned back every 14-day streak). If no freeze is
  available, the streak resets and a small point penalty applies. Points
  never go below zero — the goal is friction against skipping, not
  punishment that makes the app feel bad to reopen after a lapse. Each
  missed day is charged exactly once (the engine remembers how far it has
  reconciled), and unticking a habit takes back the points and screen time
  that tick earned.
- **Day rollover**: the app notices a new day on resume and at midnight —
  "today" moves forward, missed days are reconciled, scheduled habits get
  today's calendar block, and the morning check-in appears again.

## Backup

Settings → Data & privacy → **Export backup (JSON)** writes every table to a
single JSON file and opens the share sheet (save it to Drive, email it to
yourself, etc.). Meal photos are not included, only their file paths.
