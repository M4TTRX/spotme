import 'package:flutter/cupertino.dart';

class WorkInProgressView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Image.asset("resources/images/work_in_progress/wip.png"),
          Text(
            "Sorry bro this is still work in progress",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 28, fontFamily: "Red Hat Text"),
          ),
        ],
      ),
    );
  }
}
