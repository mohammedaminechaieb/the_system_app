import 'package:flutter/material.dart';
import '../theme/app_palette.dart';
import 'net_image.dart';

/// A large visual card — image on top, title/subtitle below, tap to open
/// detail. Used for browsing grids (martial arts, hobbies, sports) so
/// screens read as a visual catalogue rather than paragraphs of text.
class VisualCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final IconData fallbackIcon;
  final VoidCallback onTap;
  final List<Widget>? badges;

  const VisualCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.fallbackIcon,
    required this.onTap,
    this.badges,
  });

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(p.cardRadius),
      child: Container(
        decoration: BoxDecoration(
          color: p.surfaceRaised,
          borderRadius: BorderRadius.circular(p.cardRadius),
          border: Border.all(color: p.borderSoft),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 10,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  NetImage(url: imageUrl, fallbackIcon: fallbackIcon, fit: BoxFit.cover, borderRadius: BorderRadius.zero),
                  if (badges != null)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Row(children: badges!),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(13, 11, 13, 13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleLarge, maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 3),
                  Text(subtitle, style: Theme.of(context).textTheme.bodyMedium, maxLines: 2, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A horizontally scrolling row of [VisualCard]-like tiles, for "browse
/// this category" sections — replaces a vertical wall of bullet text.
class HorizontalCardScroll extends StatelessWidget {
  final double height;
  final List<Widget> children;
  const HorizontalCardScroll({super.key, required this.height, required this.children});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: children.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, i) => children[i],
      ),
    );
  }
}

/// A compact list row with a leading thumbnail image — used for detail
/// screens (technique lists, meal ideas) so even list rows feel visual
/// rather than plain text lines.
class ThumbnailRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final IconData fallbackIcon;
  final VoidCallback? onTap;
  final Widget? trailing;

  const ThumbnailRow({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.fallbackIcon,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            NetImage(url: imageUrl, fallbackIcon: fallbackIcon, height: 56, width: 56, borderRadius: BorderRadius.circular(12)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 2),
                  Text(subtitle, style: Theme.of(context).textTheme.bodyMedium, maxLines: 2, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            if (trailing != null) trailing! else Icon(Icons.chevron_right, color: p.textFaint),
          ],
        ),
      ),
    );
  }
}

/// A hero header for detail screens — full-bleed image with a gradient
/// overlay and title text sitting on top, like a magazine spread opener.
class HeroHeader extends StatelessWidget {
  final String imageUrl;
  final IconData fallbackIcon;
  final String title;
  final String? subtitle;
  final double height;

  const HeroHeader({
    super.key,
    required this.imageUrl,
    required this.fallbackIcon,
    required this.title,
    this.subtitle,
    this.height = 220,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          NetImage(url: imageUrl, fallbackIcon: fallbackIcon, fit: BoxFit.cover, borderRadius: BorderRadius.zero),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black.withOpacity(0.0), Colors.black.withOpacity(0.65)],
              ),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 18,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700)),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(subtitle!, style: TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 13)),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// A small metric tile with an icon, value, and label — used to replace
/// dense comparison tables with a scannable grid (e.g. martial arts stats).
class MetricTile extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  const MetricTile({super.key, required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(color: p.surfaceSunken, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Icon(icon, size: 16, color: p.primary),
          const SizedBox(height: 6),
          Text(value, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: p.textPrimary)),
          const SizedBox(height: 2),
          Text(label, style: TextStyle(fontSize: 9.5, color: p.textFaint, fontWeight: FontWeight.w600), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
