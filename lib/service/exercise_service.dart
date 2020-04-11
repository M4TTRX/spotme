import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_workouts/model/user_model.dart';
import 'package:home_workouts/model/exercise_model.dart';

class ExService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create exercise from firebase user
  Exercise _exerciseFromFirebaseExercise(FirebaseUser firebaseUser) {
    if (firebaseUser == null) {
      return null;
    }
    return Exercise(
      type: "Placeholder Exercise",
      amount: 5,
      unit: firebaseUser.displayName ?? "Rando",
      createDate: new DateTime.now();
    );
  }
}