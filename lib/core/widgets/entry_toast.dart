import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_palette.dart';

/// A brief, satisfying confirmation shown after logging an entry — haptic
/// buzz plus a small toast that slides up and fades, styled to match the
/// active theme rather than using the default Material SnackBar look.
void showEntryAddedToast(BuildContext context, {String message = 'Entry added', IconData icon = Icons.check_circle}) {
  HapticFeedback.lightImpact();
  final p = AppPalette.of(context);
  final overlay = Overlay.of(context);
  late OverlayEntry entry;

  entry = OverlayEntry(
    builder: (context) => _ToastWidget(
      message: message,
      icon: icon,
      palette: p,
      onDone: () => entry.remove(),
    ),
  );
  overlay.insert(entry);
}

class _ToastWidget extends StatefulWidget {
  final String message;
  final IconData icon;
  final AppPalette palette;
  final VoidCallback onDone;
  const _ToastWidget({required this.message, required this.icon, required this.palette, required this.onDone});

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slide;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 220));
    _slide = Tween(begin: const Offset(0, 0.4), end: Offset.zero).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
    Future.delayed(const Duration(milliseconds: 1400), () async {
      if (!mounted) return;
      await _controller.reverse();
      widget.onDone();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.palette;
    return Positioned(
      bottom: 100,
      left: 24,
      right: 24,
      child: FadeTransition(
        opacity: _fade,
        child: SlideTransition(
          position: _slide,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
              decoration: BoxDecoration(
                color: p.primary,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.18), blurRadius: 16, offset: const Offset(0, 6))],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(widget.icon, color: p.primaryOn, size: 18),
                  const SizedBox(width: 10),
                  Flexible(child: Text(widget.message, style: TextStyle(color: p.primaryOn, fontWeight: FontWeight.w700, fontSize: 13.5))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
