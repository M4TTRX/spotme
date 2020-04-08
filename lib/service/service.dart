import 'package:home_workouts/model/challenges/challenge_model.dart';
import 'package:home_workouts/model/challenges/challenge_progress_model.dart';
import 'package:home_workouts/model/exercise_model.dart';
import 'package:home_workouts/model/user_model.dart';
import 'package:home_workouts/model/home_model.dart';

import 'database/shared_preferences_service.dart';

class AppService {
  Stream<HomeViewData> get HomeViewDataStream async* {
    HomeViewData homeViewData = HomeViewData(
        welcomeString:
            "Welcome pichouthebest@gmail.com! You are all caught up today!",
        challengesProgress: [
          UserChallengeProgress(
            exercises: [],
            challenge: Challenge(exercise: Exercise(type: "Push Ups")),
          )
        ]);
    yield homeViewData;
  }

  static Future<User> getUser() async {
    var account = await SharedPreferencesService.getUser();
    return account;
  }

  static void setUser(String userName) async {
    var account = User(userName: userName);
    await SharedPreferencesService.putUser(account);
  }
}
