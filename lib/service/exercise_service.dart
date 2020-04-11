import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_workouts/model/user_model.dart';

class ExService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user from firebase user
  Exercise _exerciseFromFirebaseExercise(FirebaseUser firebaseUser) {
    if (firebaseUser == null) {
      return null;
    }
    return User(
      id: firebaseUser.uid,
      email: firebaseUser.email,
      username: firebaseUser.displayName ?? "Rando",
    );
  }
}