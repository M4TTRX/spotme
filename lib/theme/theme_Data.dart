import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Color values
// Primary Color
const int _primaryColorVal = 0xFF35D7B9;
const int _darkColourVal = 0xFF2A373C;
const int _lightGrayBackground = 0xFFECECEC;
const int _veryLightGrayBackground = 0xFFF3F3F3;

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

// Color Palette
const redColor = Color(_redColorVal);
const redLightColor = Color(_redLightColorVal);
const redDarkColor = Color(_redDarkColorVal);

// Text colors
const _textColor = Color(_darkColourVal);
const _primaryColoredText = Color(_darkColourVal);
const _secondaryColoredText = Color(0xFF3E5259);

final ThemeData THEME = ThemeData(
  // Light vs dark mode
  brightness: Brightness.light,

  // Define Colours
  primaryColor: primaryColor,
  accentColor: Color(_primaryColorVal),
  splashColor: Color(_veryLightGrayBackground),
  highlightColor: Color(_veryLightGrayBackground),

  // headline6 Title theme
  textTheme: TextTheme(
    headline6: GoogleFonts.poppins(
        textStyle: TextStyle(
      fontSize: 48,
      fontWeight: FontWeight.w700,
      color: _textColor,
    )),

    // headline1 (Menu Header) is used to represent large headlines like a date
    headline1: GoogleFonts.poppins(
        textStyle: TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w600,
      color: _primaryColoredText,
    )),

    // headline3 (Exercise Menu) is used to exercises usually
    //to display title of exercises
    headline2: GoogleFonts.poppins(
        textStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: _textColor,
    )),

    // headline4 (Exercise Title page) is used in the textfield for the name of the exercise
    headline4: GoogleFonts.openSans(
        textStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: _textColor,
    )),

    // bodyText2 used for smaller info
    bodyText2: GoogleFonts.openSans(
        textStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: _secondaryColoredText,
    )),

    // subtitle1 used for the smallest info
    subtitle1: GoogleFonts.openSans(
        textStyle: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: _secondaryColoredText,
    )),

    // This style is used for most buttons
    button: GoogleFonts.poppins(
        textStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: _textColor,
    )),
  ),

  inputDecorationTheme: InputDecorationTheme(
    labelStyle: GoogleFonts.openSans(
      fontSize: 26,
      fontWeight: FontWeight.w400,
      color: _textColor,
    ),
    contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
    filled: true,
    fillColor: _veryLightGrayBackgroundColor,
    focusColor: primaryColor,
    enabledBorder: OutlineInputBorder(
        gapPadding: 0,
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(style: BorderStyle.none)),
    border: OutlineInputBorder(
        gapPadding: 0,
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(style: BorderStyle.none)),
    focusedBorder: OutlineInputBorder(
        gapPadding: 0,
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(width: 2.0, color: primaryColor)),
  ),

  textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
              EdgeInsets.symmetric(vertical: 4, horizontal: 16)),
          foregroundColor: MaterialStateProperty.all<Color>(darkColour),
          backgroundColor:
              MaterialStateProperty.all<Color>(_lightGrayBackgroundColor))),
  // Define Button Themes
);
