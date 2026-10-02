import 'package:flutter/material.dart';

/// A slightly nicer push transition than Flutter's default platform route —
/// a soft fade + upward slide, used across the app wherever we push a new
/// screen. Feels more considered than the abrupt default on Android.
class FadeSlidePageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;
  FadeSlidePageRoute({required this.page})
      : super(
          transitionDuration: const Duration(milliseconds: 320),
          reverseTransitionDuration: const Duration(milliseconds: 260),
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
            return FadeTransition(
              opacity: curved,
              child: SlideTransition(
                position: Tween<Offset>(begin: const Offset(0, 0.04), end: Offset.zero).animate(curved),
                child: child,
              ),
            );
          },
        );
}

extension NavigatorPushPolished on NavigatorState {
  Future<T?> pushPolished<T>(Widget page) => push<T>(FadeSlidePageRoute<T>(page: page));
}
