import 'package:home_workouts/model/user_model.dart';
import 'package:home_workouts/model/home_model.dart';

import 'database/shared_preferences_service.dart';

class AppService {
  Stream<HomeViewData> get HomeViewDataStream async* {
    HomeViewData homeViewData = HomeViewData(
      welcomeString:
          "Welcome pichouthebest@gmail.com! You are all caught up today!",
    );
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
