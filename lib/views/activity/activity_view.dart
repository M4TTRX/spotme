import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_workouts/helpers/date_time_helper.dart';
import 'package:home_workouts/helpers/string_helper.dart';
import 'package:home_workouts/model/exercise_set.dart';

import 'package:home_workouts/service/service.dart';
import 'package:home_workouts/theme/layout_values.dart';
import 'package:home_workouts/theme/theme_Data.dart';
import 'package:home_workouts/views/add_progress/add_exercise_view.dart';
import 'package:home_workouts/views/exercise/exercise_view.dart';

import 'package:home_workouts/model/exercise_model.dart';
import 'package:home_workouts/views/shared/padding.dart';

class ActivityView extends StatefulWidget {
  final AppService service;
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
              "You have no activity! \n WTF bro! STOP SLACKING! START GRINDING!",
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
                height: MEDIUM,
              ),
              Text(
                toPrettyString(exercise.createDate!),
                style: Theme.of(context).textTheme.headline1,
              ),
              Divider(
                thickness: DIVIDER_THICKNESS,
                height: DIVIDER_THICKNESS,
                color: primaryColor,
              ),
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
                height: SMALL,
              ),
              Text(
                getTimeString(exercise.createDate),
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(
                toCapitalized(exercise.type),
                style: Theme.of(context).textTheme.headline2,
              ),
              Text(
                exercise.getDisplayAmount(),
                style: Theme.of(context).textTheme.bodyText2,
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
                padding: const EdgeInsets.only(top: 96, bottom: LARGE),
                child: Text(
                  "Activity",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            Padding(
              padding: containerPadding,
              child: Padding(
                padding: const EdgeInsets.only(bottom: MEDIUM),
                child: Text(
                  "Recommended Exercises",
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
            ),
            _getRecommendedExercises(),
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
        margin: EdgeInsets.symmetric(horizontal: LARGE, vertical: SMALLER),
        child: Row(
          children: List<Widget>.generate(
            exercises.length,
            (i) => Container(
              margin: EdgeInsets.only(
                right: MEDIUM,
              ),
              height: CARD_HEIGHT,
              width: CARD_WIDTH,
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(MEDIUM),
                boxShadow: [CARD_SHADOW],
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(MEDIUM),
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
                  padding: CARD_PADDING,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        toCapitalized(exercises[i].type),
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
