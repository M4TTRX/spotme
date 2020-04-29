import 'package:flutter/material.dart';

class SubtitleText extends Text {
  SubtitleText(String data)
      : super(
          data,
          style: TextStyle(fontSize: 24, fontFamily: "Red Hat Text", fontWeight: FontWeight.bold),
        );
}
