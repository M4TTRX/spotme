import 'package:flutter/material.dart';
import 'package:home_workouts/views/authenticate/sign_in_view.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SignInView(),
    );
  }
}
