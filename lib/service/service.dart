import 'package:home_workouts/model/challenges/challenge_model.dart';
import 'package:home_workouts/model/challenges/challenge_progress_model.dart';
import 'package:home_workouts/model/exercise_model.dart';
import 'package:home_workouts/model/user_model.dart';
import 'package:home_workouts/model/home_model.dart';
import 'package:home_workouts/service/database/firestore_database_service.dart';

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

  // gets the id of the account signed in
  Future<String> _getUserID() async {
    await for (User user in authService.user.distinct()) {
      print(user.id);
      return user.id;
    }
    return "";
    ;
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
