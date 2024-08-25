import 'package:flutter/material.dart';

class SlidePageRoute extends PageRouteBuilder {
  final Widget page;

  static const Offset beginOffset = Offset(0.0, 1.0); // Slide up from bottom
  static const Curve curve = Curves.ease;

  SlidePageRoute({
    required this.page,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var tween = Tween(begin: beginOffset, end: Offset.zero)
                .chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
}
