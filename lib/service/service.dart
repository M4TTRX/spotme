import 'package:spotme/model/database/exercise_db_model.dart';
import 'package:spotme/model/exercise_model.dart';
import 'package:spotme/model/account_model.dart';
import 'package:spotme/model/workout_model.dart';
import 'package:spotme/service/database/firestore_database_service.dart';
import 'package:uuid/uuid.dart';

import 'auth_service.dart';
import 'database/shared_preferences_service.dart';

class AppService {
  AppService({required this.account});

  // Cache values
  List<Exercise> _cachedUserExercise = [];

  // Sub Services and Databases
  // ===============================================================

  // authService manages all the authentification stuff and all
  final AuthService authService = AuthService();
  Account account;
  // Streams
  // ===============================================================

  Stream<List<Exercise>> get exerciseDataStream async* {
    List<Exercise> exerciseDataStream = [];

    // get the userID from stream
    String userID = this.account.id!;

    if (userID.length > 0) {
      final FireStoreDatabaseService fireStoreDb =
          FireStoreDatabaseService(userId: userID);

      await for (List<DatabaseExercise?> exercises
          in fireStoreDb.exercises.distinct()) {
        // add exercises
        exercises.forEach((dbExercise) {
          var exercise = Exercise.fromDatabaseExercise(dbExercise);
          if (exercise != null) {
            exerciseDataStream.add(exercise);
          }
        });
        // udpate cache
        this._cachedUserExercise = exerciseDataStream;

        yield exerciseDataStream;
      }
    } else {
      print("bad");
    }
    yield exerciseDataStream;
  }

  Stream<List<Workout>> get userWorkoutStream async* {
    List<Workout> _activeWorkouts = [];

    // get the userID from stream
    String userID = this.account.id!;

    if (userID.length > 0) {
      final FireStoreDatabaseService fireStoreDb =
          FireStoreDatabaseService(userId: userID);

      await for (List<Workout?> workouts
          in fireStoreDb.activeWorkouts.distinct()) {
        // add workouts
        workouts.forEach((workout) {
          if (workout != null) {
            _activeWorkouts.add(workout);
          }
        });
        yield _activeWorkouts;
      }
    } else {
      print("Error getting user workouts: UserId could not be retrieved");
    }
    yield _activeWorkouts;
  }

  // Methods
  // ===============================================================
  Future registerUser(String username, String email, String password) async {
    dynamic authResult =
        await authService.registerWithEmailAndPassword(email, password);
    if (authResult == null) {
      return null;
    }
    Account user = Account(username: username, email: email, id: authResult.id);
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
    String? userID = this.account.id;
    final FireStoreDatabaseService fireStoreDb =
        FireStoreDatabaseService(userId: userID);
    DatabaseExercise databaseExercise = DatabaseExercise(
      id: Uuid().v4(),
      type: exercise.type?.toUpperCase().trim() ?? "UNKNOWN",
      sets: exercise.sets ?? [],
      unit: exercise.unit?.toUpperCase().trim() ?? "",
      createDate: exercise.createDate ?? DateTime.now(),
      userID: userID,
      notes: exercise.notes ?? "",
      workout: exercise.workout?.getId(),
    );
    await fireStoreDb.upsertExercise(databaseExercise);
  }

  // putExercise stores an exercise for the user
  Future putWorkout(String name, WorkoutColor color) async {
    // get the userID
    String? userID = this.account.id;
    try {
      final FireStoreDatabaseService fireStoreDb =
          FireStoreDatabaseService(userId: userID);
      Workout workout = Workout(name, userID!, color: color);
      await fireStoreDb.upsertUserWorkout(workout);
    } catch (e) {
      print("Failed to save workout with name: $name");
    }
  }

  Future<void> deleteWorkout(String name) async {
    String? userID = this.account.id;
    try {
      final FireStoreDatabaseService fireStoreDb =
          FireStoreDatabaseService(userId: userID);
      await fireStoreDb.deleteWorkout(name + "_" + userID!);
    } catch (e) {
      print("Failed to delete workout with name: $name");
    }
  }

  void updateExerciseCache() async =>
      _cachedUserExercise = (await exerciseDataStream.toList())[0];

  Future<List<Exercise>> searchExercise(String pattern) async {
    // load exercises if they have not been loaded yet
    if (_cachedUserExercise.length == 0) {
      updateExerciseCache();
    }
    var seen = Set<String>();
    List<Exercise> suggestions = _cachedUserExercise
        .where((Exercise exercise) =>
            exercise.type!.contains(pattern.toUpperCase()))
        .toList();
    suggestions = suggestions
        .where((Exercise exercise) => seen.add(exercise.type ?? ""))
        .toList();
    return suggestions;
  }

  // SharedPreference stuff (useless)
  // =============ab==================================================
  static Future<Account?> getUser() async {
    var account = await SharedPreferencesService.getUser();
    return account;
  }

  static void setUser(String username) async {
    var account = Account(username: username);
    await SharedPreferencesService.putUser(account);
  }
}
