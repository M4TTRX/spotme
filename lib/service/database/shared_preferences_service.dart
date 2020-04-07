import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:home_workouts/model/user_model.dart';

class SharedPreferencesService {
  static final _accountPreferenceKey = "account";

  static Future putUser(User account) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_accountPreferenceKey);

    var accountJson = jsonEncode(account.toMap());
    prefs.setString(_accountPreferenceKey, accountJson);
    return;
  }

  static Future<User> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonObject = prefs.getString(_accountPreferenceKey);
    User account = User(userName: "<unknown>");
    try {
      var m = jsonDecode(jsonObject);
      account = User.fromMap(m);
    } catch (e) {
      log("Could not decode account.");
    }
    return account;
  }
}
