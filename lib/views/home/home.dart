import 'package:flutter/material.dart';
import 'package:home_workouts/model/home_model.dart';
import 'package:home_workouts/service/service.dart';
import 'package:home_workouts/views/challenge_progress/challenge_progress.dart';
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: service.homeViewDataStream,
      builder: (context, snapshot) {
        return _buildHomeBody(snapshot.data);
      },
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
        homeViewBody.add(UserChallengeProgressView(userChallengeProgress));
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
}
