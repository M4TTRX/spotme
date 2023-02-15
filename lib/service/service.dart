import 'package:flutter/foundation.dart';
import 'package:spotme/model/database/exercise_db_model.dart';
import 'package:spotme/model/exercise_model.dart';
import 'package:spotme/model/account_model.dart';
import 'package:spotme/model/workout_model.dart';
import 'package:spotme/service/database/firestore_database_service.dart';
import 'package:uuid/uuid.dart';

import 'auth_service.dart';
import 'database/shared_preferences_service.dart';

class AppService {
  AppService({required this.account}) {
    _fireStoreDb = FireStoreDatabaseService(userId: this.account.id);
  }
  late FireStoreDatabaseService _fireStoreDb;
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
      List<Workout?> workouts = await _fireStoreDb.workouts;
      await for (var exercises in _fireStoreDb.exercises.distinct()) {
        // add exercises
        print(exercises);
        exercises.forEach((dbExercise) {
          Workout? workout = null;
          for (var w in workouts) {
            if (w?.getId() == dbExercise?.workout) {
              workout = w;
              break;
            }
          }
          if (dbExercise != null) {
            exerciseDataStream.add(Exercise(
                id: dbExercise.id,
                type: dbExercise.type,
                sets: dbExercise.sets,
                unit: dbExercise.unit,
                createDate: dbExercise.createDate,
                notes: dbExercise.notes,
                workout: workout));
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
      await for (List<Workout?> workouts
          in _fireStoreDb.activeWorkouts.distinct()) {
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

    dynamic fireStoreDbResult = await _fireStoreDb.upsertUser(user);
    if (fireStoreDbResult == null) {
      return null;
    }
    return fireStoreDbResult;
  }

  // putExercise stores an exercise for the user
  Future putExercise(Exercise exercise, {String? exerciseId = null}) async =>
      await _fireStoreDb.upsertExercise(DatabaseExercise(
        // generate an ID if it does not exist yet
        id: exerciseId ?? Uuid().v4(),
      type: exercise.type?.toUpperCase().trim() ?? "UNKNOWN",
      sets: exercise.sets ?? [],
      unit: exercise.unit?.toUpperCase().trim() ?? "",
      createDate: exercise.createDate ?? DateTime.now(),
        userID: this.account.id,
      notes: exercise.notes ?? "",
      workout: exercise.workout?.getId(),
      ));

  Future deleteExercise(String exerciseID) async =>
      await _fireStoreDb.deleteExercise(exerciseID);

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
  // ===============================================================
  static Future<Account?> getUser() async {
    var account = await SharedPreferencesService.getUser();
    return account;
  }

  static void setUser(String username) async {
    var account = Account(username: username);
    await SharedPreferencesService.putUser(account);
  }
}
