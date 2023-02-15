import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotme/model/account_model.dart';
import 'package:spotme/service/auth_service.dart';
import 'package:spotme/service/service.dart';
import 'package:spotme/views/shared/buttons/danger_button.dart';
import 'package:spotme/views/shared/list_item.dart';
import 'package:spotme/views/shared/padding.dart';
import 'package:spotme/views/shared/text/headings.dart';
import 'package:spotme/views/shared/text/title.dart';
import 'package:spotme/views/shared/whitespace.dart';

import '../../theme/layout_values.dart';
import '../auth_wrapper.dart';
import '../shared/list_header.dart';

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
      padding: const EdgeInsets.only(top: 96, bottom: LayoutValues.LARGE),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Profile",
            style: Theme.of(context).textTheme.headline6,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(
              Icons.account_circle,
              size: 64,
            ),
          )
        ],
      ),
    ));
    accountBodyView.add(ListHeader(text: "User Preferences"));
    accountBodyView.add(ListItem(
      title: "Default weight unit",
      details: "Pre loaded unit when adding exercises",
    ));
    accountBodyView.add(ListHeader(text: "Account Management"));
    accountBodyView.add(
      InkWell(
        child: ListItem(
          title: "Log out",
          details: "Log off the account and delete on device data",
        ),
        onTap: () async {
          await _authService.signOut();
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) {
            return AuthWrapper();
          }), (route) => true);
        },
      ),
    );
    return ListView(
      padding: containerPadding,
      children: accountBodyView,
    );
  }
}
