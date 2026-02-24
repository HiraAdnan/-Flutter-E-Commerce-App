import 'package:flutter/material.dart';

class AppAnimations {
  AppAnimations._();

  // Durations
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration medium = Duration(milliseconds: 350);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration pageTransition = Duration(milliseconds: 300);

  // Curves
  static const Curve defaultCurve = Curves.easeInOut;
  static const Curve enterCurve = Curves.easeOut;
  static const Curve exitCurve = Curves.easeIn;
  static const Curve emphasizedCurve = Curves.easeInOutCubicEmphasized;

  // Stagger
  static const Duration staggerInterval = Duration(milliseconds: 50);
}
