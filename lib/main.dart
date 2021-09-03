import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:home_workouts/model/account_model.dart';
import 'package:home_workouts/model/account_model.dart';
import 'package:home_workouts/service/auth_service.dart';
import 'package:home_workouts/theme/theme_Data.dart';
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
              statusBarColor: Colors.white,
              systemNavigationBarColor: Colors.white,
              systemNavigationBarIconBrightness: Brightness.dark));
          if (snapshot == null) {}
          return StreamProvider<Account>.value(
            value: AuthService().user,
            initialData: Account(),
            child: MaterialApp(
              theme: THEME,
              localizationsDelegates: <LocalizationsDelegate<dynamic>>[
                DefaultMaterialLocalizations.delegate,
                DefaultWidgetsLocalizations.delegate,
                DefaultCupertinoLocalizations.delegate,
              ],
              home: AuthWrapper(),
            ),
          );
        });
  }
}
