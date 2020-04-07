import 'package:home_workouts/model/user_model.dart';
import 'package:home_workouts/model/home_model.dart';
import 'package:home_workouts/model/week_overviews/week_exercise.dart';
import 'package:home_workouts/model/week_overviews/week_overview.dart';

import 'database/shared_preferences_service.dart';

class AppService {
  Stream<HomeInfo> get homeInfoStream async* {
    HomeInfo homeInfo = HomeInfo(
        welcomeString:
            "Welcome pichouthebest@gmail.com! You are all caught up today!",
        yourWeekOverview: WeekOverview(exercises: [
          WeekExercise(completed: 200, needed: 250, type: "Push-Ups"),
          WeekExercise(completed: 30, needed: 100, type: "Planks")
        ]));
    yield homeInfo;
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
