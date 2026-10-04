import 'package:flutter/material.dart';

/// Habits store their icon as a plain name (see Habits.icon) so the DB
/// stays free of Flutter types. This maps those names to real icons.
const Map<String, IconData> kHabitIcons = {
  'check': Icons.check_circle_outline,
  'fitness_center': Icons.fitness_center,
  'self_improvement': Icons.self_improvement,
  'bedtime': Icons.bedtime_outlined,
  'menu_book': Icons.menu_book_outlined,
  'restaurant': Icons.restaurant_outlined,
  'sports_martial_arts': Icons.sports_martial_arts,
  'directions_run': Icons.directions_run,
  'water_drop': Icons.water_drop_outlined,
  'directions_walk': Icons.directions_walk,
  'music_note': Icons.music_note_outlined,
  'brush': Icons.brush_outlined,
  'code': Icons.code,
  'phone_disabled': Icons.phone_disabled_outlined,
  'wb_sunny': Icons.wb_sunny_outlined,
  'savings': Icons.savings_outlined,
};

IconData habitIcon(String name) => kHabitIcons[name] ?? Icons.check_circle_outline;

/// Human-readable label for an icon name, e.g. 'water_drop' → 'Water drop'.
String habitIconLabel(String name) {
  final words = name.replaceAll('_', ' ');
  return words.isEmpty ? name : '${words[0].toUpperCase()}${words.substring(1)}';
}
