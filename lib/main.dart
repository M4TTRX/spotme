import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:home_workouts/model/account_model.dart';
import 'package:home_workouts/service/auth_service.dart';
import 'package:home_workouts/views/auth_wrapper.dart';
import 'package:provider/provider.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
              statusBarBrightness: Brightness.light,
              systemNavigationBarColor: Colors.white,
              systemNavigationBarIconBrightness: Brightness.dark));
          return StreamProvider<Account>.value(
            value: AuthService().user,
            initialData: Account(),
            child: MaterialApp(
              theme: ThemeData(
                primarySwatch: Colors.indigo,
              ),
              home: AuthWrapper(),
            ),
          );
        });
  }
}
