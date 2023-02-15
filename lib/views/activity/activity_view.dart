import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spotme/helpers/date_time_helper.dart';
import 'package:spotme/helpers/string_helper.dart';
import 'package:spotme/model/exercise_set.dart';
import 'package:spotme/helpers/string_helper.dart';


import 'package:spotme/service/service.dart';
import 'package:spotme/theme/layout_values.dart';
import 'package:spotme/theme/theme_Data.dart';
import 'package:spotme/views/add_progress/add_exercise_view.dart';
import 'package:spotme/views/exercise/exercise_view.dart';

import 'package:spotme/model/exercise_model.dart';
import 'package:spotme/views/shared/padding.dart';

import '../shared/list_header.dart';
import '../shared/workout_chip.dart';

class ActivityView extends StatefulWidget {
  final AppService service;

  static const routeName = '/exercise';

  ActivityView({required this.service});

  @override
  _ActivityViewState createState() => _ActivityViewState(service);
}

class _ActivityViewState extends State<ActivityView> {
  _ActivityViewState(this.service);
  AppService service;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: service.exerciseDataStream,
      builder: (context, snapshot) {
        return _buildActivityBody(snapshot.data as List<Exercise>?);
      },
    );
  }

  Widget _buildActivityBody(List<Exercise>? data) {
    if (data == null || data.length == 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 1,
            child: Text(
              "You have no activity yet...",
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
    }
    // Generate list of cards
    List<Widget> activityViewBody = [];
    DateTime? currDay = DateTime(0, 0, 0, 0);
    for (var exercise in data) {
      // Creating the Day section of the list
      if (!isSameDay(currDay!, exercise.createDate!)) {
        activityViewBody.add(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: LayoutValues.MEDIUM,
              ),
              ListHeader(text: toPrettyString(exercise.createDate!)),
            ],
          ),
        );
        currDay = exercise.createDate;
      }
      // List an Exercise
      activityViewBody.add(Container(
        child: InkWell(
          onTap: () {
            HapticFeedback.mediumImpact();
            Navigator.of(this.context)
                .push(MaterialPageRoute(builder: (context) {
              return ExerciseView(
                service: service,
                exercise: exercise,
              );
            }));
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: LayoutValues.SMALL,
              ),
              Text(
                getTimeString(exercise.createDate),
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(
                exercise.type.capitalize() ?? "Unknown exercise",
                style: Theme.of(context).textTheme.headline2,
              ),
              SizedBox(
                height: LayoutValues.SMALLER,
              ),
              Row(
                children: [
                  exercise.workout == null
                      ? Container()
                      : Row(
                          children: [
                            WorkoutChip(exercise.workout!),
                            SizedBox(
                              width: LayoutValues.SMALL,
                            )
                          ],
                        ),
                  Text(
                    exercise.getDisplayAmount(),
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
            ],
          ),
        ),
      ));
    }

    activityViewBody.add(SizedBox(
      height: 128,
    ));

    // Return in Listview
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: containerPadding,
              child: Padding(
                padding:
                    const EdgeInsets.only(
                    top: LayoutValues.LARGEST, bottom: LayoutValues.SMALL),
                child: Text(
                  "Activity",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            // Padding(
            //   padding: containerPadding,
            //   child: Padding(
            //     padding: const EdgeInsets.only(bottom: LayoutValues.MEDIUM),
            //     child: Text(
            //       "Recommended Exercises",
            //       style: Theme.of(context).textTheme.headline2,
            //     ),
            //   ),
            // ),
            // _getRecommendedExercises(),
            Padding(
              padding: containerPadding,
              child: Column(
                children: activityViewBody,
              ),
            )
          ]),
        ),
      ],
    );
  }

  Widget _getRecommendedExercises() {
    var exercises = [
      Exercise(
        type: "Push Ups",
        createDate: DateTime.now(),
        sets: [
          ExerciseSet(repetitions: 20),
          ExerciseSet(repetitions: 20),
          ExerciseSet(repetitions: 20)
        ],
      ),
      Exercise(
        type: "Diamond Push Ups",
        createDate: DateTime.now(),
        sets: [
          ExerciseSet(repetitions: 20),
          ExerciseSet(repetitions: 20),
          ExerciseSet(repetitions: 20)
        ],
      ),
      Exercise(
        type: "Diamond Push Ups",
        createDate: DateTime.now(),
        sets: [
          ExerciseSet(repetitions: 20),
          ExerciseSet(repetitions: 20),
          ExerciseSet(repetitions: 20)
        ],
      ),
      Exercise(
        type: "Diamond Push Ups",
        createDate: DateTime.now(),
        sets: [
          ExerciseSet(repetitions: 20),
          ExerciseSet(repetitions: 20),
          ExerciseSet(repetitions: 20)
        ],
      ),
      Exercise(
        type: "Diamond Push Ups",
        createDate: DateTime.now(),
        sets: [
          ExerciseSet(repetitions: 20),
          ExerciseSet(repetitions: 20),
          ExerciseSet(repetitions: 20)
        ],
      ),
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: LayoutValues.LARGE, vertical: LayoutValues.SMALLER),
        child: Row(
          children: List<Widget>.generate(
            exercises.length,
            (i) => Container(
              margin: EdgeInsets.only(
                right: LayoutValues.MEDIUM,
              ),
              height: LayoutValues.CARD_HEIGHT,
              width: LayoutValues.CARD_WIDTH,
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(LayoutValues.MEDIUM),
                boxShadow: [LayoutValues.CARD_SHADOW],
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(LayoutValues.MEDIUM),
                onTap: () async {
                  await Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return AddExerciseView(
                      exercise: exercises[i],
                      service: this.service,
                    );
                  }));
                },
                child: Padding(
                  padding: LayoutValues.CARD_PADDING,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        exercises[i].type.capitalize() ?? "Unknown exercise",
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      Text(
                        exercises[i].getDisplayAmount(),
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
