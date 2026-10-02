import 'package:flutter/material.dart';

import 'app_palette.dart';

/// Makes the active [AppPalette] available to any widget via
/// `AppPalette.of(context)` without needing a WidgetRef everywhere —
/// installed once near the root of the widget tree (see AppShell) and
/// rebuilt automatically whenever the Riverpod theme provider changes.
class PaletteScope extends InheritedWidget {
  final AppPalette palette;
  const PaletteScope({super.key, required this.palette, required super.child});

  static AppPalette of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<PaletteScope>();
    assert(scope != null, 'No PaletteScope found in context — wrap the app root with one.');
    return scope!.palette;
  }

  @override
  bool updateShouldNotify(PaletteScope oldWidget) => oldWidget.palette.id != palette.id;
}
