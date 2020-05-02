import 'package:flutter/material.dart';

class WhiteAppBar extends AppBar {
  WhiteAppBar()
      : super(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
        );
}
