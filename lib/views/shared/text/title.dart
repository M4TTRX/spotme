import 'package:flutter/material.dart';

class TitleText extends Text {
  TitleText(String data, {color: Colors.black})
      : super(
          data,
          style: TextStyle(
              fontSize: 28,
              fontFamily: "Red Hat Text",
              color: color ?? Colors.black),
        );
}
