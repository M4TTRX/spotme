import 'package:flutter/material.dart';
import 'package:home_workouts/model/user_model.dart';
import 'package:home_workouts/views/authenticate/authenticate_view.dart';
import 'package:home_workouts/views/main_navigation/main_navigarion_view.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return MainNavigationView();
    }
  }
}
