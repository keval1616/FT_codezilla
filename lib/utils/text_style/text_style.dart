import 'package:flutter/material.dart';

class TxtFontFamily {
  static const String gilroy = "gilroy";
  static const String inter = "inter";
  static const String oswald = "Oswald";
  static const String roboto = "Roboto";
}

extension TextStyleExtensions on TextStyle {
  // Weights
  TextStyle get bold => weight(FontWeight.w600);

  // Styles
  TextStyle get medium20 => customStyle(
    fontSize: 20,
    letterSpacing: 0.0,
    weight: FontWeight.w500,
  );
  TextStyle get normal25w600 => customStyle(
    fontSize: 25,
    letterSpacing: 0.0,
    weight: FontWeight.w600,
  );
  TextStyle get normal30w600 => customStyle(
    fontSize: 30,
    letterSpacing: 0.0,
    weight: FontWeight.w600,
  );
  TextStyle get normal60w400 => customStyle(
    fontSize: 16,
    letterSpacing: 0.0,
    weight: FontWeight.w400,
  );
  TextStyle get normal14w400 => customStyle(
    fontSize: 14,
    letterSpacing: 0.0,
    weight: FontWeight.w400,
  );
  TextStyle get normal16w100 => customStyle(
    fontSize: 16,
    letterSpacing: 0.0,
    weight: FontWeight.w300,
  );
  TextStyle get normal20w600 => customStyle(
    fontSize: 20,
    letterSpacing: 0.0,
    weight: FontWeight.w600,
  );
  TextStyle get normal14 => customStyle(
    fontSize: 14,
    letterSpacing: 0.0,
    weight: FontWeight.w400,
  );
  TextStyle get bold28 => customStyle(
    fontSize: 28,
    letterSpacing: 0.0,
    weight: FontWeight.bold,
  );
  TextStyle get normal16w400 => customStyle(
    fontSize: 16,
    letterSpacing: 0.0,
    weight: FontWeight.w400,
  );
  TextStyle get normal24w600 => customStyle(
    fontSize: 24,
    letterSpacing: 0.0,
    weight: FontWeight.w600,
  );
  TextStyle get normal12w400 => customStyle(
    fontSize: 12,
    letterSpacing: 0.0,
    weight: FontWeight.w400,
  );
  TextStyle get normal14w6700 => customStyle(
    fontSize: 14,
    letterSpacing: 0.0,
    weight: FontWeight.w400,
  );
  TextStyle get normal32w600 => customStyle(
    fontSize: 32,
    letterSpacing: 0.0,
    weight: FontWeight.w600,
  );
  TextStyle get normal14w600 => customStyle(
    fontSize: 14,
    letterSpacing: 0.0,
    weight: FontWeight.w600,
  );
  TextStyle get normal16w300 => customStyle(
    fontSize: 16,
    letterSpacing: 0.0,
    weight: FontWeight.w300,
  );
  TextStyle get normal14w500 => customStyle(
    fontSize: 14,
    letterSpacing: 0.0,
    weight: FontWeight.w500,
  );
  TextStyle get normal17w500 => customStyle(
    fontSize: 17,
    letterSpacing: 0.0,
    weight: FontWeight.w500,
  );
  TextStyle get normal17w600 => customStyle(
    fontSize: 17,
    letterSpacing: 0.0,
    weight: FontWeight.w600,
  );
  TextStyle get normal12w300 => customStyle(
    fontSize: 12,
    letterSpacing: 0.0,
    weight: FontWeight.w300,
  );
  TextStyle get normal16w600 => customStyle(
    fontSize: 16,
    letterSpacing: 0.0,
    weight: FontWeight.w600,
  );
  //world street app..........
  TextStyle get normal16w900 => customStyle(
    fontSize: 16,
    letterSpacing: 0.0,
    weight: FontWeight.w900,
  );
  TextStyle get normal16w500 => customStyle(
    fontSize: 16,
    letterSpacing: 0.0,
    weight: FontWeight.w500,
  );
  TextStyle get normal24Bold => customStyle(
    fontSize: 24,
    letterSpacing: 0.0,
    weight: FontWeight.bold,
  );
  TextStyle get normal14Medium => customStyle(
    fontSize: 14,
    letterSpacing: 0.0,
    weight: FontWeight.w500,
  );

  /// Shortcut for color
  TextStyle textColor(Color v) => copyWith(color: v);

  /// Shortcut for fontWeight
  TextStyle weight(FontWeight v) => copyWith(fontWeight: v);

  /// Shortcut for fontSize
  TextStyle size(double v) => copyWith(fontSize: v);

  /// Shortcut for letterSpacing
  TextStyle letterSpace(double v) => copyWith(letterSpacing: v);

  TextStyle customStyle({
    required double letterSpacing,
    required double fontSize,
    required FontWeight weight,
  }) =>
      copyWith(
        letterSpacing: letterSpacing,
        fontSize: fontSize,
        fontWeight: weight,
      );
}
