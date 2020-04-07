import 'package:flutter/material.dart';
import 'package:home_workouts/model/home_model.dart';
import 'package:home_workouts/service/auth_service.dart';
import 'package:home_workouts/service/service.dart';
import 'package:home_workouts/views/exercise_progress/exercise_progress_view.dart';
import 'package:home_workouts/views/shared/padding.dart';
import 'package:home_workouts/views/shared/scroll_behavior.dart';
import 'package:home_workouts/views/shared/text/title.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  AppService service = AppService();

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Logout'),
            onPressed: () async {
              await _authService.signOut();
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder<Object>(
        stream: service.HomeViewDataStream,
        builder: (context, snapchot) {
          return _buildHomeBody(snapchot.data);
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
    for (var exercise in data.challengesProgress) {
      // homeViewBody.add(ExerciseProgressView(exercise));
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
}
