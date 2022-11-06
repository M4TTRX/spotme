import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:spotme/model/account_model.dart';
import 'package:spotme/service/auth_service.dart';
import 'package:spotme/theme/theme_Data.dart';
import 'package:spotme/views/auth_wrapper.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    App(),
  );
}

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
    ]);
  }
}
class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //     future: Firebase.initializeApp(),
    //     builder: (context, snapshot) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.white,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark));
    return StreamProvider<Account>.value(
      value: AuthService().user,
      initialData: Account(),
      child: MaterialApp(
        
        theme: lightTheme,
        darkTheme: darkTheme,

        // used to restore the naviagator when killing the app
        restorationScopeId: 'app',

        localizationsDelegates: <LocalizationsDelegate<dynamic>>[
          DefaultMaterialLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
        ],
        home: AuthWrapper(),
      ),
    );
    // });
  }
}
