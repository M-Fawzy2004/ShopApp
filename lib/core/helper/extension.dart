import 'package:flutter/material.dart';

extension Navigation on BuildContext {
  void pushNamedAndRemoveUntil(String routeName, {Object? arguments}) {
    Navigator.of(this).pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  void pushNamed(String routeName, {Object? arguments}) {
    Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  void pop() => Navigator.of(this).pop();

  void navigateWithSlideTransition(Widget page) {
    Navigator.of(this).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final begin = const Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  void navigateWithBottomSlideTransition(Widget page) {
    Navigator.of(this).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionDuration: const Duration(milliseconds: 600),
        reverseTransitionDuration: const Duration(milliseconds: 400),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final begin = const Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeOutCubic;
          const reverseCurve = Curves.easeInCubic;

          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));

          var reverseTween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: reverseCurve));

          return SlideTransition(
            position: animation.drive(
              secondaryAnimation.status == AnimationStatus.forward
                  ? reverseTween
                  : tween,
            ),
            child: child,
          );
        },
      ),
    );
  }
}