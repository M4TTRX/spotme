import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_workouts/model/account_model.dart';
import 'package:home_workouts/service/auth_service.dart';
import 'package:home_workouts/service/service.dart';
import 'package:home_workouts/views/shared/buttons/danger_button.dart';
import 'package:home_workouts/views/shared/padding.dart';
import 'package:home_workouts/views/shared/text/headings.dart';
import 'package:home_workouts/views/shared/text/title.dart';
import 'package:home_workouts/views/shared/white_app_bar.dart';
import 'package:home_workouts/views/shared/whitespace.dart';

class AccountView extends StatefulWidget {
  final AppService service;
  AccountView({required this.service});

  @override
  _AccountViewState createState() => _AccountViewState(service);
}

final AuthService _authService = AuthService();

class _AccountViewState extends State<AccountView> {
  _AccountViewState(this.service);
  AppService service;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildAccountViewBody(service.account as Account?),
    );
  }

  Widget _buildAccountViewBody(Account? user) {
    // Null check
    if (user == null) {
      return Container();
    }
    List<Widget> accountBodyView = [];
    accountBodyView.add(Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(
              Icons.account_circle,
              size: 64,
            ),
          ),
          TitleText(user.username ?? "")
        ],
      ),
    ));
    accountBodyView.add(
      Divider(
        height: 32,
      ),
    );

    // Change username section
    accountBodyView.add(InkWell(
      enableFeedback: true,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(Icons.alternate_email, size: 32),
          ),
          Body("Change username")
        ],
      ),
    ));
    accountBodyView.add(Divider(
      height: 32,
    ));

    // Modify password section
    accountBodyView.add(InkWell(
      enableFeedback: true,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(Icons.lock_outline, size: 32),
          ),
          Body("Change Password")
        ],
      ),
    ));
    accountBodyView.add(Divider(
      height: 32,
    ));
    accountBodyView.add(WhiteSpace());
    accountBodyView.add(
      DangerButton(
        'Logout',
        () async {
          await _authService.signOut();
        },
      ),
    );
    return Container(
      padding: containerPadding,
      child: Column(
        children: accountBodyView,
      ),
    );
  }
}
