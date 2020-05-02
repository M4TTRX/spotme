import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_workouts/model/selected_screen_model.dart';
import 'package:home_workouts/service/auth_service.dart';
import 'package:home_workouts/views/account/account_view.dart';
import 'package:home_workouts/views/activity/activity_view.dart';
import 'package:home_workouts/views/add_progress/add_exercise_view.dart';
import 'package:home_workouts/views/home/home.dart';
import 'package:home_workouts/views/shared/text/title.dart';
import 'package:home_workouts/views/work_in_progress/wip_view.dart';

class MainNavigationView extends StatefulWidget {
  @override
  _MainNavigationViewState createState() => _MainNavigationViewState();
}

class _MainNavigationViewState extends State<MainNavigationView> {
  SelectedScreen _selectedScreen = SelectedScreen.HOME;

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              MaterialButton(
                minWidth: 48,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.home,
                      color: _selectedScreen == SelectedScreen.HOME
                          ? Colors.indigo
                          : Colors.black,
                    ),
                    Text("Home"),
                  ],
                ),
                onPressed: () {
                  setState(() {
                    _selectedScreen = SelectedScreen.HOME;
                  });
                },
              ),
              SizedBox(
                width: 64,
              ),
              MaterialButton(
                minWidth: 48,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.history,
                      color: _selectedScreen == SelectedScreen.ACTIVITY
                          ? Colors.indigo
                          : Colors.black,
                    ),
                    Text("Activity"),
                  ],
                ),
                onPressed: () {
                  setState(() {
                    _selectedScreen = SelectedScreen.ACTIVITY;
                  });
                },
              ),
            ],
          ),
        ),
        shape: CircularNotchedRectangle(),
      ),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        title: _getTitle(),
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(
              Icons.account_circle,
              size: 32,
            ),
            onPressed: () async {
              await _openAccountView(context);
            },
            label: Text(""),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: _returnSelectedView(),
    );
  }

  Widget _returnSelectedView() {
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
          _selectedScreen = SelectedScreen.HOME;
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
