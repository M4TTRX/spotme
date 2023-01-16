import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spotme/model/account_model.dart';
import 'package:spotme/model/selected_screen_model.dart';
import 'package:spotme/service/service.dart';
import 'package:spotme/theme/layout_values.dart';
import 'package:spotme/views/account/account_view.dart';
import 'package:spotme/views/activity/activity_view.dart';
import 'package:spotme/views/add_progress/add_exercise_view.dart';
import 'package:spotme/views/shared/text/title.dart';
import 'package:provider/provider.dart';
import 'package:animations/animations.dart';

class MainNavigationView extends StatefulWidget {
  @override
  _MainNavigationViewState createState() => _MainNavigationViewState();
}

class _MainNavigationViewState extends State<MainNavigationView> {
  SelectedScreen _selectedScreen = SelectedScreen.ACTIVITY;
  late AppService service;
  int _selectedScreenIndex = 0;

  SharedAxisTransitionType? _transitionType =
      SharedAxisTransitionType.horizontal;
  bool _reverseAnimation = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<Account>(
        builder: (context, Account account, Widget? widget) {
      this.service = AppService(account: account);
      return ScrollConfiguration(
        behavior: CupertinoScrollBehavior(),
        child: Scaffold(
          bottomNavigationBar: NavigationBar(
            backgroundColor: Theme.of(context).colorScheme.background,
            height: LayoutValues.LARGEST,
            onDestinationSelected: _updateSelectedView,
            selectedIndex: _selectedScreenIndex,
            destinations: [
              NavigationDestination(
                label: "Activity",
                icon: Icon(Icons.assignment_outlined),
                selectedIcon: Icon(Icons.assignment),
              ),
              NavigationDestination(
                label: "Account",
                icon: Icon(Icons.account_circle_outlined),
                selectedIcon: Icon(Icons.account_circle),
              ),
            ],
          ),
          floatingActionButton: _getFloatingActionButton(),
          backgroundColor: Colors.white,
          body: PageTransitionSwitcher(
            reverse: !_reverseAnimation,
            transitionBuilder: (
              Widget child,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) {
              return SharedAxisTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                transitionType: _transitionType!,
                child: child,
              );
            },
            child: _returnSelectedView(),
          ),
        ),
      );
    });
  }

  void _updateSelectedView(int newViewIndex) {
    this._reverseAnimation = newViewIndex > this._selectedScreenIndex;
    this._selectedScreenIndex = newViewIndex;
    switch (newViewIndex) {
      case 1:
        _selectedScreen = SelectedScreen.ACCOUNT;
        break;
      default:
        _selectedScreen = SelectedScreen.ACTIVITY;
    }
    setState(() {});
  }

  Widget _returnSelectedView() {
    switch (_selectedScreen) {
      case SelectedScreen.ACCOUNT:
        {
          return AccountView(service: service);
        }
      case SelectedScreen.ACTIVITY:
        {
          return ActivityView(
            service: service,
          );
        }
      default:
        {
          _selectedScreen = SelectedScreen.ACTIVITY;
          return ActivityView(service: service);
        }
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
      case SelectedScreen.CHALLENGES:
        {
          return TitleText("Challenges");
        }
      case SelectedScreen.ACTIVITY:
        {
          return Text(
            "Activity",
            style: Theme.of(context).textTheme.headline6,
          );
        }
      case SelectedScreen.ACCOUNT:
        {
          return TitleText("Account");
        }
      default:
        {
          _selectedScreen = SelectedScreen.ACTIVITY;
          return TitleText("");
        }
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

  _getFloatingActionButton() {
    switch (_selectedScreen) {
      case SelectedScreen.ACTIVITY:
        return FloatingActionButton.extended(
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
        );
      default:
        return null;
    }
  }
}
