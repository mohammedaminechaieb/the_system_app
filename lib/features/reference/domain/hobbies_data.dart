import 'package:flutter/material.dart';

class HobbyCategoryInfo {
  final String category;
  final String imageUrl;
  final IconData icon;
  final List<String> examples;
  const HobbyCategoryInfo({required this.category, required this.imageUrl, required this.icon, required this.examples});
}

class HobbiesData {
  HobbiesData._();

  static const categories = [
    HobbyCategoryInfo(
      category: 'Physical',
      imageUrl: 'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=900&q=80',
      icon: Icons.directions_run,
      examples: ['Martial arts', 'Climbing', 'Swimming', 'Cycling'],
    ),
    HobbyCategoryInfo(
      category: 'Intellectual',
      imageUrl: 'https://images.unsplash.com/photo-1456513080510-7bf3a84b82f8?w=900&q=80',
      icon: Icons.school_outlined,
      examples: ['Language learning', 'Online course', 'Chess'],
    ),
    HobbyCategoryInfo(
      category: 'Creative',
      imageUrl: 'https://images.unsplash.com/photo-1465847899084-d164df4dedc6?w=900&q=80',
      icon: Icons.palette_outlined,
      examples: ['Cooking', 'Guitar/piano', 'Drawing', 'Writing'],
    ),
    HobbyCategoryInfo(
      category: 'Relaxing',
      imageUrl: 'https://images.unsplash.com/photo-1512820790803-83ca734da794?w=900&q=80',
      icon: Icons.self_improvement,
      examples: ['Reading', 'Gaming', 'Tai Chi', 'Photography'],
    ),
    HobbyCategoryInfo(
      category: 'Social',
      imageUrl: 'https://images.unsplash.com/photo-1529156069898-49953e39b3ac?w=900&q=80',
      icon: Icons.groups_outlined,
      examples: ['Team sport', 'Board games', 'Friends meetup'],
    ),
  ];

  static const bestReturn = [
    ('Language learning', 'Huge free resources, measurable progress', Icons.translate),
    ('Cooking', 'Compounds with nutrition goals, cheap to start', Icons.restaurant),
    ('Guitar/piano', 'Well-resourced free self-teaching, fast feedback', Icons.music_note),
    ('Chess', 'Free (lichess.org), builds focus, fits 15-min blocks', Icons.grid_on),
  ];
}
