import 'package:home_workouts/model/challenges/challenge_model.dart';
import 'package:home_workouts/model/challenges/challenge_progress_model.dart';
import 'package:home_workouts/model/database/exercise_db_model.dart';
import 'package:home_workouts/model/exercise_model.dart';
import 'package:home_workouts/model/user_model.dart';
import 'package:home_workouts/model/home_model.dart';
import 'package:home_workouts/service/database/firestore_database_service.dart';
import 'package:uuid/uuid.dart';

import 'auth_service.dart';
import 'database/shared_preferences_service.dart';

class AppService {
  // Sub Services and Databases
  // ===============================================================

  // authService manages all the authentification stuff and all
  final AuthService authService = AuthService();
  // Streams
  // ===============================================================
  Stream<HomeViewData> get homeViewDataStream async* {
    HomeViewData homeViewData = HomeViewData(challengesProgress: [
      UserChallengeProgress(
        exercises: [],
        challenge: Challenge(exercise: Exercise(type: "Push Ups")),
      )
    ]);

    // get the userID from stream
    String userID = await _getUserID();

    // fetch user data if possible
    if (userID.length > 0) {
      final FireStoreDatabaseService fireStoreDb =
          FireStoreDatabaseService(userId: userID);

      await for (User user in fireStoreDb.users.distinct()) {
        print(user.username);
        homeViewData.welcomeString = "Welcome " + user.username + "!";
        yield homeViewData;
      }
    }

    yield homeViewData;
  }

  Stream<List<Exercise>> get exerciseDataStream async* {
    /*Exercise exerciseDataStream = Exercise(challengesProgress: [
      UserChallengeProgress(
        exercises: [],
        challenge: Challenge(exercise: Exercise(type: "Push Ups")),
      )
    ]);*/
    /*
    Exercise exerciseDataStream;

    // get the userID from stream
    String userID = await _getUserID();

    // fetch user data if possible
    if (userID.length > 0) {
      final FireStoreDatabaseService fireStoreDb =
          FireStoreDatabaseService(userId: userID);

      await for (User user in fireStoreDb.users.distinct()) {
        print(user.username);
        exerciseDataStream.welcomeString = "Welcome " + user.username + "!";
        yield exerciseDataStream;
      }
    }
    */
    List<Exercise> exerciseDataStream = new List();

    // get the userID from stream
    String userID = await _getUserID();

    if (userID.length > 0) {
      final FireStoreDatabaseService fireStoreDb =
          FireStoreDatabaseService(userId: userID);

      await for (User user in fireStoreDb.users.distinct()) {
          exerciseDataStream.add(Exercise(
            type: "Push Ups",
            amount: 25,
            unit: "reps",
            createDate: new DateTime.now()
          ));

          exerciseDataStream.add(Exercise(
            type: "Sit Ups",
            amount: 25,
            unit: "reps",
            createDate: new DateTime.now()
          ));
          yield exerciseDataStream;
      }
    }

    yield exerciseDataStream;
  }

  // ========================================================================

  // gets the id of the account signed in
  Future<String> _getUserID() async {
    await for (User user in authService.user.distinct()) {
      print(user.id);
      return user.id;
    }
    return "";
  }

  // gets the id of the account signed in
  Future<String> _getWelcomeString(FireStoreDatabaseService fireStoreDb) async {
    await for (User user in fireStoreDb.users.distinct()) {
      print(user.username);
      return user.username;
    }
    return "";
    ;
  }

  // Methods
  // ===============================================================
  Future registerUser(String username, String email, String password) async {
    dynamic authResult =
        await authService.registerWithEmailAndPassword(email, password);
    if (authResult == null) {
      return null;
    }
    User user = User(username: username, email: email, id: authResult.id);
    final FireStoreDatabaseService fireStoreDb =
        FireStoreDatabaseService(userId: authResult.id);

    dynamic fireStoreDbResult = await fireStoreDb.upsertUser(user);
    if (fireStoreDbResult == null) {
      return null;
    }
    return fireStoreDbResult;
  }

  // putExercise stores an exercise for the user
  Future putExercise(Exercise exercise) async {
    // get the userID
    String userID = await _getUserID();
    final FireStoreDatabaseService fireStoreDb =
        FireStoreDatabaseService(userId: userID);
    DatabaseExercise databaseExercise = DatabaseExercise(
      id: Uuid().v4(),
      type: exercise.type ?? "Unknown Exercise Type",
      amount: exercise.amount ?? 0.0,
      unit: exercise.unit ?? "",
      createDate: DateTime.now(),
      userID: userID,
    );
    await fireStoreDb.upsertExercise(databaseExercise);
  }

  // SharedPreference stuff (useless)
  // =============ab==================================================
  static Future<User> getUser() async {
    var account = await SharedPreferencesService.getUser();
    return account;
  }

  static void setUser(String username) async {
    var account = User(username: username);
    await SharedPreferencesService.putUser(account);
  }
}
