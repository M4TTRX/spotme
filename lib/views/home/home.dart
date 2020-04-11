import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_workouts/model/home_model.dart';
import 'package:home_workouts/service/auth_service.dart';
import 'package:home_workouts/service/service.dart';
import 'package:home_workouts/views/add_progress/add_exercise_view.dart';
import 'package:home_workouts/views/challenge_progress/challenge_progress.dart';
import 'package:home_workouts/views/shared/padding.dart';
import 'package:home_workouts/views/shared/scroll_behavior.dart';
import 'package:home_workouts/views/shared/text/headings.dart';
import 'package:home_workouts/views/shared/text/title.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  AppService service = AppService();

  final AuthService _authService = AuthService();

  // currentNavBarIndex is the index of which page we are on in the navigation bar
  int _currentNavBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(Icons.home),
            Icon(Icons.history),
          ],
        ),
        shape: CircularNotchedRectangle(),
        color: Colors.blueGrey,
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
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0.0,
      //   actions: <Widget>[
      //     FlatButton.icon(
      //       icon: Icon(Icons.person),
      //       label: Text('Logout'),
      //       onPressed: () async {
      //         await _authService.signOut();
      //       },
      //     )
      //   ],
      // ),
      backgroundColor: Colors.white,
      body: StreamBuilder<Object>(
        stream: service.homeViewDataStream,
        builder: (context, snapshot) {
          return _buildHomeBody(snapshot.data);
        },
      ),
    );
  }

  Widget _buildHomeBody(HomeViewData data) {
    if (data == null) {
      return Container();
    }
    // Generate list of cards
    var homeViewBody = List<Widget>();
    homeViewBody.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: TitleText(data.welcomeString ?? "Welcome"),
      ),
    );
    if (data.challengesProgress != null) {
      for (var userChallengeProgress in data.challengesProgress) {
        homeViewBody.add(UserChalleneProgressView(userChallengeProgress));
      }
    }
    // Return in Listview
    return ScrollConfiguration(
      behavior: BasicScrollBehaviour(),
      child: ListView(
        padding: containerPadding,
        children: homeViewBody,
      ),
    );
  }

  _addExercise(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return AddExerciseView();
    }));
  }
}
