import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Color values
const int _primaryColorVal = 0xFF35D7B9;
const int _primaryColorTextVal = 0xFF1F816F;
const int _darkColourVal = 0xFF2A373C;
const int _darkGreyVal = 0xFF444444;
const int _highlightColorVal = 0x33FFFFFF;

// Text colors
const _textColor = Color(_darkColourVal);
const _lighterText = Color(_darkGreyVal);
const _primaryColoredText = Color(_primaryColorTextVal);

final THEME = ThemeData(
  // Light vs dark mode
  brightness: Brightness.light,

  // Define Colours
  primaryColor: Color(_primaryColorVal),
  accentColor: Color(_primaryColorVal),
  splashColor: Color(_highlightColorVal),
  highlightColor: Color(_highlightColorVal),

  // Define Text theme
  textTheme: TextTheme(
    headline6: GoogleFonts.poppins(
        textStyle: TextStyle(
      fontSize: 48,
      fontWeight: FontWeight.w600,
      color: _textColor,
    )),

    // headline1 (Menu Header) is used to represent large headlines like a date
    headline1: GoogleFonts.openSans(
        textStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: _primaryColoredText,
    )),

    // headline2 is used for the Floating Action Button
    headline2: GoogleFonts.poppins(
        textStyle: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: _textColor,
    )),

    // headline3 (Exercise Menu) is used to exercises usually
    //to display title of exercises
    headline3: GoogleFonts.poppins(
        textStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: _textColor,
    )),

    // bodyText2 used for smaller info
    bodyText2: GoogleFonts.openSans(
        textStyle: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: _lighterText,
    )),

    // This style is used for most buttons
    button: GoogleFonts.poppins(
        textStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: _textColor,
    )),
  ),
);
