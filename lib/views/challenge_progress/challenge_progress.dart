import 'package:flutter/material.dart';
import 'package:home_workouts/model/challenges/challenge_progress_model.dart';
import 'package:home_workouts/model/exercise_model.dart';
import 'package:home_workouts/views/add_progress/add_exercise_view.dart';
import 'package:home_workouts/views/shared/buttons/basic_button.dart';
import 'package:home_workouts/views/shared/text/headings.dart';
import 'package:home_workouts/views/shared/whitespace.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class UserChalleneProgressView extends StatefulWidget {
  final UserChallengeProgress _challengeProgress;

  UserChalleneProgressView(this._challengeProgress);

  @override
  _UserChalleneProgressViewState createState() =>
      _UserChalleneProgressViewState(_challengeProgress);
}

class _UserChalleneProgressViewState extends State<UserChalleneProgressView> {
  _UserChalleneProgressViewState(this._challengeProgress);

  final UserChallengeProgress _challengeProgress;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: <Widget>[
                  Heading2(_challengeProgress.getChallengeType()),
                  WhiteSpace(),
                  Text(_challengeProgress.getCompleted().toString() +
                      " / " +
                      _challengeProgress.getNeeded().toString()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: LinearPercentIndicator(
                progressColor: Colors.indigo,
                backgroundColor: Colors.grey[200],
                linearStrokeCap: LinearStrokeCap.roundAll,
                lineHeight: 16.0,
                animation: true,
                percent: _challengeProgress.getCompleted() /
                    _challengeProgress.getNeeded(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: BasicButton("Add Progress", () {
                    _addExercise(context);
                  }),
                ),
              ],
            )
          ]),
    );
  }

  _addExercise(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return AddExerciseView();
    }));
  }
}
