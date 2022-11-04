import 'package:flutter/material.dart';
import 'package:spotme/model/account_model.dart';
import 'package:spotme/views/authenticate/authenticate_view.dart';
import 'package:spotme/views/main_navigation/main_navigarion_view.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final account = Provider.of<Account>(context);
    if (account.id == null) {
      // a null accountID implies that no user is logged in
      return Authenticate();
    } else {
      return MainNavigationView();
    }
  }
}
