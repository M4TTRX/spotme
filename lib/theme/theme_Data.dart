import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotme/theme/layout_values.dart';

// Color values
// Primary Color
const int _primaryColorVal = 0xFF35D7B9;
const int _darkColourVal = 0xFF2A373C;
const int _lightGrayBackground = 0xFFECECEC;
const int _veryLightGrayBackground = 0xFFF3F3F3;
const int _shadowColourVal = 0x552A373C;

// Colour Palette Valuers
const int _redColorVal = 0xFFFD584E;
const int _redLightColorVal = 0xFFFFC1BD;
const int _redDarkColorVal = 0xFF7B120B;

// Rest
const int _darkGreyVal = 0xFF444444;
const int _highlightColorVal = 0x33FFFFFF;

// Colors
const Color primaryColor = Color(_primaryColorVal);
const _lightGrayBackgroundColor = Color(_lightGrayBackground);
const _veryLightGrayBackgroundColor = Color(_veryLightGrayBackground);
const darkColour = Color(_darkColourVal);
const shadowColour = Color(_shadowColourVal);

// Text colors
const _textColor = Color(_darkColourVal);
const _primaryColoredText = Color(_darkColourVal);
const _secondaryColoredText = Color(0xFF3E5259);

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF006B5A),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFF64FADB),
  onPrimaryContainer: Color(0xFF00201A),
  secondary: Color(0xFF4B635C),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFCDE8DF),
  onSecondaryContainer: Color(0xFF06201A),
  tertiary: Color(0xFF426278),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFC7E7FF),
  onTertiaryContainer: Color(0xFF001E2E),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFFBFCFF),
  onBackground: Color(0xFF001E2E),
  surface: Color(0x192D4162),
  onSurface: Color(0xFF001E2E),
  surfaceVariant: Color(0xFFDBE5E0),
  onSurfaceVariant: Color(0xFF3F4946),
  outline: Color(0xFF6F7975),
  onInverseSurface: Color(0xFFE5F2FF),
  inverseSurface: Color(0xFF00344D),
  inversePrimary: Color(0xFF3FDDBF),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF006B5A),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF3FDDBF),
  onPrimary: Color(0xFF00382E),
  primaryContainer: Color(0xFF005143),
  onPrimaryContainer: Color(0xFF64FADB),
  secondary: Color(0xFFB1CCC3),
  onSecondary: Color(0xFF1D352F),
  secondaryContainer: Color(0xFF334B45),
  onSecondaryContainer: Color(0xFFCDE8DF),
  tertiary: Color(0xFFAACBE4),
  onTertiary: Color(0xFF103447),
  tertiaryContainer: Color(0xFF2A4A5F),
  onTertiaryContainer: Color(0xFFC7E7FF),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF001E2E),
  onBackground: Color(0xFFC8E6FF),
  surface: Color(0xFF001E2E),
  onSurface: Color(0xFFC8E6FF),
  surfaceVariant: Color(0xFF3F4946),
  onSurfaceVariant: Color(0xFFBFC9C4),
  outline: Color(0xFF89938F),
  onInverseSurface: Color(0xFF001E2E),
  inverseSurface: Color(0xFFC8E6FF),
  inversePrimary: Color(0xFF006B5A),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF3FDDBF),
);

final ThemeData lightTheme = themeBuilder(lightColorScheme);
final ThemeData darkTheme = themeBuilder(darkColorScheme);

ThemeData themeBuilder(ColorScheme colorScheme) => ThemeData(
      // toggle Material 3
      useMaterial3: true,
      colorScheme: colorScheme,

      // // Define Colours
      // primaryColor: primaryColor,
      // accentColor: Color(_primaryColorVal),
      // splashColor: Color(_veryLightGrayBackground),
      // highlightColor: Color(_veryLightGrayBackground),

      // headline6 Title theme
      textTheme: TextTheme(
        headline6: GoogleFonts.poppins(
            textStyle: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.w700,
          color: colorScheme.onBackground,
        )),

        // headline1 (Menu Header) is used to represent large headlines like a date
        headline1: GoogleFonts.poppins(
            textStyle: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w600,
          color: colorScheme.onBackground,
        )),

        // headline3 (Exercise Menu) is used to exercises usually
        //to display title of exercises
        headline2: GoogleFonts.poppins(
            textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: colorScheme.onBackground,
        )),

        // headline4 (Exercise Title page) is used in the textfield for the name of the exercise
        headline4: GoogleFonts.openSans(
            textStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: colorScheme.onBackground,
        )),

        // bodyText2 used for smaller info
        bodyText2: GoogleFonts.openSans(
            textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: colorScheme.onSecondaryContainer,
        )),

        // subtitle1 used for the smallest info
        subtitle1: GoogleFonts.openSans(
            textStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: colorScheme.onSecondaryContainer,
        )),

        // This style is used for most buttons
        button: GoogleFonts.poppins(
            textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: colorScheme.onBackground,
        )),
      ),

      inputDecorationTheme: InputDecorationTheme(
        fillColor: colorScheme.surface,
        labelStyle: GoogleFonts.openSans(
          fontSize: 26,
          fontWeight: FontWeight.w400,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        filled: true,
        enabledBorder: OutlineInputBorder(
            gapPadding: 0,
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(style: BorderStyle.none)),
        border: OutlineInputBorder(
            gapPadding: 0,
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(style: BorderStyle.none)),
        focusColor: colorScheme.surfaceVariant,
        focusedBorder: OutlineInputBorder(
            gapPadding: 0,
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: colorScheme.primaryContainer)),
      ),

      // Define Button Themes
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
            EdgeInsets.symmetric(vertical: 4, horizontal: 16)),
        foregroundColor:
            MaterialStateProperty.all<Color>(colorScheme.onSecondaryContainer),
        backgroundColor:
            MaterialStateProperty.all<Color>(colorScheme.secondaryContainer),
      )),

      // Define Card Theme
      cardTheme: CardTheme(
        elevation:
            0, // Wrap cards in container and use the custom CARD_SHADOW instead
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MEDIUM),
        ),
      ),
    );
