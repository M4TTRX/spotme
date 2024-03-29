import 'package:flutter/material.dart';

class Heading1 extends Text {
  Heading1(String data, {color: Colors.black})
      : super(
          data,
          style: TextStyle(
              fontSize: 24,
              fontFamily: "Red Hat Text",
              color: color ?? Colors.black),
        );
}

class Heading2 extends Text {
  Heading2(String data, {color: Colors.black})
      : super(
          data,
          style: TextStyle(
              fontSize: 18,
              fontFamily: "Red Hat Text",
              color: color ?? Colors.black),
        );
}

class Body extends Text {
  Body(String data)
      : super(
          data,
          style: TextStyle(fontSize: 18),
        );
}

class ButtonBodyText extends Text {
  ButtonBodyText(String data, {Color? color, double? fontSize})
      : super(
          data,
          style: TextStyle(
            fontSize: fontSize ?? 18,
            fontWeight: FontWeight.bold,
            color: color ?? Colors.black,
          ),
        );
}
