import 'package:flutter/material.dart';

import 'package:home_workouts/model/user_model.dart';
import 'package:home_workouts/service/auth_service.dart';
import 'package:home_workouts/views/auth_wrapper.dart';
import 'package:provider/provider.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: AuthWrapper(),
      ),
    );
  }
}
