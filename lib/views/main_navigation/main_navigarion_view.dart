import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_workouts/model/account_model.dart';
import 'package:home_workouts/model/selected_screen_model.dart';
import 'package:home_workouts/service/service.dart';
import 'package:home_workouts/views/account/account_view.dart';
import 'package:home_workouts/views/activity/activity_view.dart';
import 'package:home_workouts/views/add_progress/add_exercise_view.dart';
import 'package:home_workouts/views/home/home_view.dart';
import 'package:home_workouts/views/shared/text/title.dart';
import 'package:home_workouts/views/work_in_progress/wip_view.dart';
import 'package:provider/provider.dart';

class MainNavigationView extends StatefulWidget {
  @override
  _MainNavigationViewState createState() => _MainNavigationViewState();
}

class _MainNavigationViewState extends State<MainNavigationView> {
  SelectedScreen _selectedScreen = SelectedScreen.ACTIVITY;
  late AppService service;

  @override
  Widget build(BuildContext context) {
    return Consumer<Account>(
        builder: (context, Account account, Widget? widget) {
      this.service = AppService(account: account);
      return ScrollConfiguration(
        behavior: CupertinoScrollBehavior(),
        child: Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              HapticFeedback.mediumImpact();
              await _addExercise(context);
              setState(() {});
            },
            elevation: 2,
            focusElevation: 3,
            highlightElevation: 4,
            label: Text(
              "Add Exercise",
              style: Theme.of(context).textTheme.headline2,
            ),
            icon: Icon(
              Icons.add,
              size: 32,
            ),
          ),
          backgroundColor: Colors.white,
          body: _returnSelectedView(),
        ),
      );
    });
  }

  Widget _returnSelectedView() {
    return ActivityView(service: service);
    switch (_selectedScreen) {
      case SelectedScreen.CHALLENGES:
        {
          return WorkInProgressView();
        }
        break;
      case SelectedScreen.ACTIVITY:
        {
          return ActivityView(
            service: service,
          );
        }
        break;
      default:
        {
          _selectedScreen = SelectedScreen.HOME;
          return ActivityView(service: service);
        }
        break;
    }
  }

  Widget _getTitle() {
    switch (_selectedScreen) {
      case SelectedScreen.HOME:
        {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: TitleText("Home"),
          );
        }
        break;
      case SelectedScreen.CHALLENGES:
        {
          return TitleText("Challenges");
        }
        break;
      case SelectedScreen.ACTIVITY:
        {
          return Text(
            "Activity",
            style: Theme.of(context).textTheme.headline6,
          );
        }
        break;
      case SelectedScreen.ACCOUNT:
        {
          return TitleText("Account");
        }
        break;
      default:
        {
          _selectedScreen = SelectedScreen.ACTIVITY;
          return TitleText("");
        }
        break;
    }
  }

  _addExercise(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return AddExerciseView(
        service: service,
      );
    }));
  }

  _openAccountView(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return AccountView(
        service: service,
      );
    }));
  }
}
