// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAaOEZ6ci6kSs6RiY0IQxuh4inn8fQ891g',
    appId: '1:1094908042337:web:a1260ad20a5d7aa517de20',
    messagingSenderId: '1094908042337',
    projectId: 'home-workout-271903',
    authDomain: 'home-workout-271903.firebaseapp.com',
    databaseURL: 'https://home-workout-271903.firebaseio.com',
    storageBucket: 'home-workout-271903.appspot.com',
    measurementId: 'G-KW1ERWGNMW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD5tZ8BaB_F1yB9AiUsS1zfuW6Bqy7H22Q',
    appId: '1:1094908042337:android:4018cd24cf07ea0917de20',
    messagingSenderId: '1094908042337',
    projectId: 'home-workout-271903',
    databaseURL: 'https://home-workout-271903.firebaseio.com',
    storageBucket: 'home-workout-271903.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAnVyfVZdrSaf5lNI2bi86pXGil7y7oDvI',
    appId: '1:1094908042337:ios:51724f39c8becf8517de20',
    messagingSenderId: '1094908042337',
    projectId: 'home-workout-271903',
    databaseURL: 'https://home-workout-271903.firebaseio.com',
    storageBucket: 'home-workout-271903.appspot.com',
    iosClientId: '1094908042337-0kpl6t62roo56dtiu03hbctsoe01jn9h.apps.googleusercontent.com',
    iosBundleId: 'com.example.spotme',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAnVyfVZdrSaf5lNI2bi86pXGil7y7oDvI',
    appId: '1:1094908042337:ios:51724f39c8becf8517de20',
    messagingSenderId: '1094908042337',
    projectId: 'home-workout-271903',
    databaseURL: 'https://home-workout-271903.firebaseio.com',
    storageBucket: 'home-workout-271903.appspot.com',
    iosClientId: '1094908042337-0kpl6t62roo56dtiu03hbctsoe01jn9h.apps.googleusercontent.com',
    iosBundleId: 'com.example.spotme',
  );
}