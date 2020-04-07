import 'package:flutter/material.dart';
import 'package:home_workouts/model/week_overviews/week_exercise.dart';
import 'package:home_workouts/views/shared/buttons/basic_button.dart';
import 'package:home_workouts/views/shared/text/headings.dart';
import 'package:home_workouts/views/shared/whitespace.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ExerciseProgressView extends Container {
  ExerciseProgressView(WeekExercise exercise)
      : super(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: <Widget>[
                      Heading2(exercise.type),
                      WhiteSpace(),
                      Text(exercise.completed.toString() +
                          " / " +
                          exercise.needed.toString()),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: LinearPercentIndicator(
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    lineHeight: 16.0,
                    animation: true,
                    percent: exercise.completed / exercise.needed,
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
