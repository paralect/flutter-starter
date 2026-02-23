import 'package:flutter/material.dart';

class AppRadius {
  AppRadius._();

  static const double small = 4;
  static const double medium = 8;
  static const double large = 12;
  static const double xl = 16;
  static const double full = 9999;

  static BorderRadius get smallRadius => BorderRadius.circular(small);
  static BorderRadius get mediumRadius => BorderRadius.circular(medium);
  static BorderRadius get largeRadius => BorderRadius.circular(large);
  static BorderRadius get xlRadius => BorderRadius.circular(xl);
  static BorderRadius get fullRadius => BorderRadius.circular(full);
}
