import 'package:home_workouts/model/database/exercise_db_model.dart';
import 'package:home_workouts/model/exercise_model.dart';
import 'package:home_workouts/model/user_model.dart';
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

  Stream<List<Exercise>> get exerciseDataStream async* {
    List<Exercise> exerciseDataStream = new List();

    // get the userID from stream
    String userID = await _getUserID();

    if (userID.length > 0) {
      final FireStoreDatabaseService fireStoreDb =
          FireStoreDatabaseService(userId: userID);

      await for (List<Exercise> exercises in fireStoreDb.exercises.distinct()) {
        print(exercises);
        exerciseDataStream = exercises;
        yield exerciseDataStream;
      }
    }

    yield exerciseDataStream;
  }

  Stream<User> get userStream async* {
    String userID = await _getUserID();
    if (userID.length > 0) {
      final FireStoreDatabaseService fireStoreDb =
          FireStoreDatabaseService(userId: userID);

      await for (User user in fireStoreDb.users.distinct()) {
        yield user;
      }
    }
    yield User();
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
      sets: exercise.sets ?? [],
      unit: exercise.unit ?? "",
      createDate: exercise.createDate ?? DateTime.now(),
      userID: userID,
      notes: exercise.notes ?? "",
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
