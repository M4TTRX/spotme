import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_workouts/model/home_model.dart';
import 'package:home_workouts/service/service.dart';
import 'package:home_workouts/views/exercise_progress/exercise_progress_view.dart';

class AddProgress extends StatefulWidget {
  AddProgress({Key key}) : super(key: key);
  @override
  _AddProgressState createState() => _AddProgressState();
}

class _AddProgressState extends State<AddProgress> {
  AppService service = AppService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            HapticFeedback.lightImpact();
          },
          label: new Text("Log new exercise", style: TextStyle(fontSize: 16))),
      body: StreamBuilder<Object>(
        stream: service.homeInfoStream,
        builder: (context, snapchot) {
          return _buildHomeBody(snapchot.data);
        },
      ),
    );
  }

  Widget _buildHomeBody(HomeInfo data) {
    // Generate list of cards
    var quizCardList = List<Widget>();
    quizCardList.add(Text(data.welcomeString));
    for (var exercise in data.yourWeekOverview.exercises) {
      quizCardList.add(ExerciseProgressView(exercise));
    }
    // Return in listview
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
      children: quizCardList,
    );
  }
}
