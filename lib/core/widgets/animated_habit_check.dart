import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_palette.dart';

/// A checkbox with a satisfying tactile response: haptic tick on toggle,
/// a spring "pop" scale animation, and a checkmark that draws in rather
/// than just appearing. Used for every habit toggle in the app so the
/// core daily interaction feels good to repeat, not just functional.
class AnimatedHabitCheck extends StatefulWidget {
  final bool done;
  final VoidCallback onTap;
  final double size;

  const AnimatedHabitCheck({super.key, required this.done, required this.onTap, this.size = 24});

  @override
  State<AnimatedHabitCheck> createState() => _AnimatedHabitCheckState();
}

class _AnimatedHabitCheckState extends State<AnimatedHabitCheck> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 260));
    _scale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.28).chain(CurveTween(curve: Curves.easeOut)), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 1.28, end: 1.0).chain(CurveTween(curve: Curves.elasticOut)), weight: 60),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    HapticFeedback.mediumImpact();
    if (!widget.done) _controller.forward(from: 0);
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return GestureDetector(
      onTap: _handleTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedBuilder(
        animation: _scale,
        builder: (context, child) => Transform.scale(scale: _scale.value, child: child),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            color: widget.done ? p.primary : Colors.transparent,
            border: Border.all(color: widget.done ? p.primary : p.border, width: 2),
            borderRadius: BorderRadius.circular(widget.size * 0.3),
            boxShadow: widget.done ? [BoxShadow(color: p.primary.withOpacity(0.35), blurRadius: 8, offset: const Offset(0, 2))] : null,
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 150),
            transitionBuilder: (child, anim) => ScaleTransition(scale: anim, child: child),
            child: widget.done
                ? Icon(Icons.check, key: const ValueKey('checked'), size: widget.size * 0.62, color: p.primaryOn)
                : const SizedBox.shrink(key: ValueKey('unchecked')),
          ),
        ),
      ),
    );
  }
}
