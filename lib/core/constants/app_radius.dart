import 'package:flutter/material.dart';

class AppRadius {
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
  static const double xxxl = 32.0;
  static const double card = 24.0;
  static const double full = 999.0;

  static BorderRadius get circularSm => BorderRadius.circular(sm);
  static BorderRadius get circularMd => BorderRadius.circular(md);
  static BorderRadius get circularLg => BorderRadius.circular(lg);
  static BorderRadius get circularXl => BorderRadius.circular(xl);
  static BorderRadius get circularXxl => BorderRadius.circular(xxl);
  static BorderRadius get circularCard => BorderRadius.circular(card);
  static BorderRadius get circularFull => BorderRadius.circular(full);
}
