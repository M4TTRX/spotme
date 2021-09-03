import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_workouts/model/account_model.dart';
import 'package:home_workouts/model/exercise_model.dart';
import 'package:home_workouts/service/client/exercise_service_client.dart';

class ExerciseService {
  final exerciseServiceClient = ExerciseServiceClient();

  Future<List<Exercise>> getFeedRecommendedExercises(Account account) async {
    var exercises =
        await exerciseServiceClient.getRecommendedExercises(account);
    return exercises;
  }
}
