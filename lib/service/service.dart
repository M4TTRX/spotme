import 'package:home_workouts/model/database/exercise_db_model.dart';
import 'package:home_workouts/model/exercise_model.dart';
import 'package:home_workouts/model/exercise_set.dart';
import 'package:home_workouts/service/client/exercise_service_client.dart';
import 'package:home_workouts/service/database/firestore_database_service.dart';
import 'package:uuid/uuid.dart';
import 'package:home_workouts/model/account_model.dart';

import 'auth_service.dart';
import 'database/shared_preferences_service.dart';
import 'exercise_service.dart';

class AppService {
  late Account account;
  final AuthService authService = AuthService();
  final ExerciseService exerciseService = ExerciseService();
  late FireStoreDatabaseService fireStoreDb;

  AppService(Account account) {
    this.account = account;
    String userID = account.id!;
    if (userID.length > 0) {
      this.fireStoreDb = FireStoreDatabaseService(userId: userID);
    }
    ;
  }

  // Sub Services and Databases
  // ===============================================================

  // authService manages all the authentification stuff and all

  // Streams
  // ===============================================================

  Stream<List<Exercise>> get exerciseDataStream async* {
    List<Exercise> exerciseDataStream = [];

    // get the userID from stream
    String userID = this.account.id!;

    if (userID.length > 0) {
      await for (List<Exercise?> exercises
          in fireStoreDb.exercises.distinct()) {
        print(exercises);
        // add exercises
        exercises.forEach((exercise) {
          if (exercise != null) {
            exerciseDataStream.add(exercise);
          }
        });
        yield exerciseDataStream;
      }
    } else {
      print("bad");
    }
    yield exerciseDataStream;
  }

  Stream<List<Exercise?>> get recommendedExercisesDataStream async* {
    List<Exercise> exercises = [];

    // get the userID from stream
    String userID = this.account.id!;
    exercises =
        await this.exerciseService.getFeedRecommendedExercises(this.account);
    yield exercises;
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
      type: exercise.type?.toUpperCase() ?? "UNKNOWN",
      sets: exercise.sets ?? [],
      unit: exercise.unit?.toUpperCase() ?? "",
      createDate: exercise.createDate ?? DateTime.now(),
      userID: userID,
      notes: exercise.notes ?? "",
    );
    await fireStoreDb.upsertExercise(databaseExercise);
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
