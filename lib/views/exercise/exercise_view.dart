import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_workouts/helpers/date_time_helper.dart';
import 'package:home_workouts/helpers/string_helper.dart';
import 'package:home_workouts/model/exercise_model.dart';
import 'package:home_workouts/model/exercise_set.dart';
import 'package:home_workouts/service/service.dart';
import 'package:home_workouts/theme/layout_values.dart';
import 'package:home_workouts/theme/theme_Data.dart';
import 'package:home_workouts/views/shared/padding.dart';
import 'package:home_workouts/views/shared/scroll_behavior.dart';
import 'package:uuid/uuid.dart';

class ExerciseView extends StatefulWidget {
  final AppService service;
  final Exercise? exercise;
  ExerciseView({required this.service, required this.exercise});

  @override
  _ExerciseViewState createState() => _ExerciseViewState(service, exercise);
}

class _ExerciseViewState extends State<ExerciseView> {
  _ExerciseViewState(this.service, this.exercise);

  // Can be use to implement default vallues in text fields
  Exercise? exercise;
  final AppService service;

  // Form Key used to validate the form input
  final _formKey = GlobalKey<FormState>();

  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      backgroundColor: Colors.white,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    exercise = exercise ?? Exercise(type: "", unit: "", sets: [ExerciseSet()]);
    return ListView(
      padding: containerPadding,
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                getDayAndTimeString(exercise!.createDate),
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Text(
                toCapitalized(exercise!.type),
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(
                height: LARGE,
              ),
              Text(
                "Details",
                style: Theme.of(context).textTheme.headline1,
              ),
              Divider(
                thickness: DIVIDER_THICKNESS,
                height: DIVIDER_THICKNESS,
                color: primaryColor,
              ),
              Container(
                height: SMALL,
              ),
              _displaySets(exercise),
              _displayNotes(exercise!),
            ],
          ),
        )
      ],
    );
  }

  Widget _displayNotes(Exercise exercise) {
    return (exercise.notes?.isEmpty ?? true)
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: SMALL,
              ),
              Text(
                "Notes",
                style: Theme.of(context).textTheme.headline2,
              ),
              Text(
                exercise.notes ?? "",
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ],
          );
  }

  bool areThereWeights(List<ExerciseSet>? sets) {
    // Check if Exercise is null
    if (sets == null) {
      return false;
    }
    for (var set in sets) {
      if (set.amount != null || set.amount! > 0) {
        return true;
      }
    }
    return false;
  }

  Widget _displaySets(Exercise? exercise) {
    if (exercise == null ||
        exercise.sets == null ||
        exercise.sets!.length == 0) {
      return Container();
    }
    var sets = exercise.sets!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          areThereWeights(sets) ? "Repetitions & Weights" : "Repetitions",
          style: Theme.of(context).textTheme.headline2,
        ),
        ...List.generate(
            sets.length,
            (i) => Text(sets[i].repetitions.toString() +
                // Display the amount if it exists
                (sets[i].amount == null || sets[i].amount == 0
                    ? ""
                    : (" x " + sets[i].amount.toString())) +
                // Display the unit if there is one
                (exercise.unit == null
                    ? ""
                    : (" " + toCapitalized(exercise.unit)))))
      ],
    );
  }
}
