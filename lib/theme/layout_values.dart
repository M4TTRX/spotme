import 'package:flutter/cupertino.dart';
import 'package:spotme/theme/theme_Data.dart';

class LayoutValues {
  static double DIVIDER_THICKNESS = 3;
// Laryout values for whitespace
  static const double SMALLEST = 2;
  static const double SMALLER = 4;
  static const double SMALL = 8;
  static const double MEDIUM = 16;
  static const double LARGE = 24;
  static const double LARGER = 32;
  static const double EVEN_LARGER = 48;
  static const double LARGEST = 64;

// Cards
  static const double CARD_HEIGHT = 156.0;
  static const double CARD_WIDTH = 156.0;
  static const EdgeInsets CARD_PADDING = EdgeInsets.all(MEDIUM);
  static const BoxShadow CARD_SHADOW = BoxShadow(
    color: shadowColor,
    blurRadius: 5.0,
  );

  // Workout Chips
  static const int WORKOUT_CHIP_BACKGROUND_ALPHA = 128;
  static const int WORKOUT_CHIP_SELECTED_ALPHA = 223;
  static const double WORKOUT_CHIP_TEXT_DARKEN = 0.5;
}
