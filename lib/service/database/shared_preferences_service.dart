import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:home_workouts/model/account_model.dart';

class SharedPreferencesService {
  static final _accountPreferenceKey = "account";

  static Future putUser(Account account) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_accountPreferenceKey);

    var accountJson = jsonEncode(account.toMap());
    prefs.setString(_accountPreferenceKey, accountJson);
    return;
  }

  static Future<Account?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonObject = prefs.getString(_accountPreferenceKey)!;
    Account? account = Account(username: "<unknown>");
    try {
      var m = jsonDecode(jsonObject);
      account = Account.fromMap(m);
    } catch (e) {
      log("Could not decode account.");
    }
    return account;
  }
}
