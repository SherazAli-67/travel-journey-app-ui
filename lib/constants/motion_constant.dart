import 'package:flutter/animation.dart';

class MotionConstant {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 250);
  static const Duration slow = Duration(milliseconds: 400);

  static const Curve enterCurve = Curves.easeOutCubic;
  static const Curve selectCurve = Curves.easeInOut;

  static const Duration staggerStep = Duration(milliseconds: 50);

  static const double tapScale = 0.96;
  static const double slideDistance = 24.0;
}
