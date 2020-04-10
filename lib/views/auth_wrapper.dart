import 'package:flutter/material.dart';
import 'package:home_workouts/model/user_model.dart';
import 'package:home_workouts/views/authenticate/authenticate.dart';
import 'package:provider/provider.dart';

import 'home/home.dart';
import 'activity/activity.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return ActivityView();
      //return HomeView();
    }
  }
}
