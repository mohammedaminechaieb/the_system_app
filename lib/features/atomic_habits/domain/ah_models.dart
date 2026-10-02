class AhChapter {
  final String id;
  final int number;
  final String title;
  final String subtitle;
  final String readTime;
  final List<AhSection> sections;
  const AhChapter({
    required this.id,
    required this.number,
    required this.title,
    required this.subtitle,
    required this.readTime,
    required this.sections,
  });
}

class AhSection {
  final String? heading;
  final String body;
  final List<String>? bullets;
  final String? calloutLabel; // 'key idea', 'example', 'applied to you'
  const AhSection({this.heading, required this.body, this.bullets, this.calloutLabel});
}
