import 'package:flutter/material.dart';

class ToolTipCustomShape extends ShapeBorder {
  final bool usePadding;
  ToolTipCustomShape({this.usePadding = true});

  @override
  EdgeInsetsGeometry get dimensions =>
      EdgeInsets.only(top: usePadding ? 20 : 0); // Adjust padding to the top

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path();

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    rect =
        Rect.fromPoints(rect.topLeft + const Offset(0, 20), rect.bottomRight);
    return Path()
      ..moveTo(rect.topCenter.dx - 10, rect.topCenter.dy) // Start point for arrow
      ..relativeLineTo(10, -20) // Draw arrow line upwards
      ..relativeLineTo(10, 20) // Draw arrow line downwards
      ..moveTo(rect.left, rect.top) // Move to start of rounded rectangle
      ..addRRect(
          RRect.fromRectAndRadius(rect, Radius.circular(rect.height / 3)))
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
