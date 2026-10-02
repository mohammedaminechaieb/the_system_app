import 'package:flutter/material.dart';

import '../theme/app_palette.dart';

/// A network image with a graceful themed fallback — shows an icon on a
/// tinted background if the image fails to load (no connection, dead URL,
/// etc.) instead of Flutter's default broken-image icon. Also shows a
/// subtle shimmer-less placeholder while loading.
class NetImage extends StatelessWidget {
  final String url;
  final IconData fallbackIcon;
  final double? height;
  final double? width;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  const NetImage({
    super.key,
    required this.url,
    required this.fallbackIcon,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    final radius = borderRadius ?? BorderRadius.circular(p.cardRadius * 0.6);

    return ClipRRect(
      borderRadius: radius,
      child: Image.network(
        url,
        height: height,
        width: width,
        fit: fit,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return _placeholder(p, loading: true);
        },
        errorBuilder: (context, error, stackTrace) => _placeholder(p, loading: false),
      ),
    );
  }

  Widget _placeholder(AppPalette p, {required bool loading}) {
    return Container(
      height: height,
      width: width,
      color: p.primarySoft,
      alignment: Alignment.center,
      child: loading
          ? SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(strokeWidth: 2, color: p.primary.withOpacity(0.5)),
            )
          : Icon(fallbackIcon, color: p.primary.withOpacity(0.55), size: (height ?? 80) * 0.32),
    );
  }
}
