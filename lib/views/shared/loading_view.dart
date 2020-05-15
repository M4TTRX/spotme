import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Center(
          child: SpinKitThreeBounce(
            color: Colors.indigo,
            size: 50,
            duration: Duration(milliseconds: 1000),
          ),
        ));
  }
}
