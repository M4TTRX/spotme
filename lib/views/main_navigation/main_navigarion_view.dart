import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_workouts/model/selected_screen_model.dart';
import 'package:home_workouts/views/account/account_view.dart';
import 'package:home_workouts/views/activity/activity_view.dart';
import 'package:home_workouts/views/add_progress/add_exercise_view.dart';
import 'package:home_workouts/views/home/home_view.dart';
import 'package:home_workouts/views/shared/text/title.dart';
import 'package:home_workouts/views/work_in_progress/wip_view.dart';

class MainNavigationView extends StatefulWidget {
  @override
  _MainNavigationViewState createState() => _MainNavigationViewState();
}

class _MainNavigationViewState extends State<MainNavigationView> {
  SelectedScreen _selectedScreen = SelectedScreen.ACTIVITY;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Colors.indigo,
        onPressed: () async {
          HapticFeedback.mediumImpact();
          await _addExercise(context);
          setState(() {});
        },
        child: Icon(
          Icons.add,
          size: 32,
        ),
      ),
      appBar: AppBar(
        title: _getTitle(),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: _returnSelectedView(),
    );
  }

  Widget _returnSelectedView() {
    return PageView(
      children: <Widget>[ActivityView(), AccountView()],
    );
    switch (_selectedScreen) {
      case SelectedScreen.HOME:
        {
          return HomeView();
        }
        break;
      case SelectedScreen.CHALLENGES:
        {
          return WorkInProgressView();
        }
        break;
      case SelectedScreen.ACTIVITY:
        {
          return ActivityView();
        }
        break;
      case SelectedScreen.ACCOUNT:
        {
          return AccountView();
        }
        break;
      default:
        {
          _selectedScreen = SelectedScreen.HOME;
          return HomeView();
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
          return TitleText("Activity");
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
      return AddExerciseView();
    }));
  }

  _openAccountView(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return AccountView();
    }));
  }
}
