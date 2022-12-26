import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spotme/helpers/date_time_helper.dart';
import 'package:spotme/helpers/string_helper.dart';
import 'package:spotme/model/exercise_model.dart';
import 'package:spotme/model/exercise_set.dart';
import 'package:spotme/service/service.dart';
import 'package:spotme/theme/layout_values.dart';
import 'package:spotme/theme/theme_Data.dart';
import 'package:spotme/views/shared/padding.dart';
import 'package:spotme/views/shared/scroll_behavior.dart';
import 'package:spotme/views/shared/workout_chip.dart';
import 'package:uuid/uuid.dart';

class ExerciseView extends StatefulWidget {
  final AppService service;
  final Exercise? exercise;

  static const routeName = '/exercise';

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
              Row(
                children: [
                  exercise?.workout != null
                      ? Padding(
                          padding:
                              const EdgeInsets.only(right: LayoutValues.SMALL),
                          child: WorkoutChip(exercise!.workout!),
                        )
                      : Container(),
                  Text(
                    getDayAndTimeString(exercise!.createDate),
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
              Text(
                exercise?.type.capitalize() ?? "Unknown exercise",
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(
                height: LayoutValues.LARGE,
              ),
              Text(
                "Details",
                style: Theme.of(context).textTheme.headline1,
              ),
              Divider(
                thickness: LayoutValues.DIVIDER_THICKNESS,
                height: LayoutValues.DIVIDER_THICKNESS,
                color: primaryColor,
              ),
              Container(
                height: LayoutValues.SMALL,
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
                height: LayoutValues.SMALL,
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
                    : (" " +
                        (exercise.unit.capitalize() ?? "Unknown Exercise")))))
      ],
    );
  }
}
