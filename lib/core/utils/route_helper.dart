import 'package:flutter/material.dart';

class SlideUpRoute extends PageRouteBuilder {
  final Widget page;

  SlideUpRoute({required this.page})
    : super(
        transitionDuration: const Duration(milliseconds: 400),
        reverseTransitionDuration: const Duration(milliseconds: 400),

        pageBuilder: (context, animation, secondaryAnimation) => page,

        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;

          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          );

          final tween = Tween(begin: begin, end: end);

          return SlideTransition(
            position: tween.animate(curvedAnimation),
            child: child,
          );
        },
      );
}

class SlideRightToLeftRoute extends PageRouteBuilder {
  final Widget page;

  SlideRightToLeftRoute({required this.page})
    : super(
        transitionDuration: const Duration(milliseconds: 400),
        reverseTransitionDuration: const Duration(milliseconds: 400),

        pageBuilder: (context, animation, secondaryAnimation) => page,

        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;

          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          );

          final tween = Tween(begin: begin, end: end);

          return SlideTransition(
            position: tween.animate(curvedAnimation),
            child: child,
          );
        },
      );
}
