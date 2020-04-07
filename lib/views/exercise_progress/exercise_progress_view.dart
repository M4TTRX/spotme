import 'package:flutter/material.dart';
import 'package:home_workouts/model/challenges/challenge_progress.dart';
import 'package:home_workouts/views/shared/buttons/basic_button.dart';
import 'package:home_workouts/views/shared/text/headings.dart';
import 'package:home_workouts/views/shared/whitespace.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ChallengeProgressView extends Container {
  ChallengeProgressView(ChallengeProgress challengeProgress)
      : super(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: <Widget>[
                      Heading2(challengeProgress.getChallengeType()),
                      WhiteSpace(),
                      Text(challengeProgress.getCompleted().toString() +
                          " / " +
                          challengeProgress.getNeeded().toString()),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: LinearPercentIndicator(
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    lineHeight: 16.0,
                    animation: true,
                    percent: challengeProgress.getCompleted() /
                        challengeProgress.getNeeded(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: BasicButton("Add Progress", () {}),
                    ),
                  ],
                )
              ]),
        );
}
