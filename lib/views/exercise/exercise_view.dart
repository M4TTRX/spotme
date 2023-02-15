import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spotme/helpers/date_time_helper.dart';
import 'package:spotme/helpers/string_helper.dart';
import 'package:spotme/model/exercise_model.dart';
import 'package:spotme/model/exercise_set.dart';
import 'package:spotme/service/service.dart';
import 'package:spotme/theme/layout_values.dart';
import 'package:spotme/views/shared/padding.dart';
import 'package:spotme/views/shared/workout_chip.dart';

import '../add_progress/add_exercise_view.dart';
import '../shared/buttons/buttonStyles.dart';
import '../shared/list_header.dart';

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
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        actions: [
          IconButton(onPressed: _editExercise, icon: Icon(Icons.edit_outlined)),
          IconButton(
              onPressed: () => _confirmExerciseDeletion(context),
              icon: Icon(Icons.delete_outline_rounded))
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    var _titleStyle = (int length) {
      if (length > 16) {
        return Theme.of(context).textTheme.headline6?.copyWith(fontSize: 28);
      }
      if (length > 10) {
        return Theme.of(context).textTheme.headline6?.copyWith(fontSize: 36);
      }
      // 48
      return Theme.of(context).textTheme.headline6;
    };
    exercise = exercise ?? Exercise(type: "", unit: "", sets: [ExerciseSet()]);
    return ListView(
      padding: containerPadding,
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: LayoutValues.SMALL),
                child: Text(
                  exercise?.type.capitalize() ?? "Unknown exercise",
                  style: _titleStyle(exercise?.type?.length ?? 0),
                  maxLines: 2,
                ),
              ),
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
              Container(
                height: LayoutValues.MEDIUM,
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
        ListHeader(
          text: areThereWeights(sets) ? "Repetitions & Weights" : "Repetitions",
        ),
        SizedBox(
          height: LayoutValues.SMALL,
        ),
        for (ExerciseSet set in sets)
          _displayRep(set.repetitions!, set.amount, exercise.unit!),
      ],
    );
  }

  Widget _displayRep(int reps, double? amount, String unit) {
    var style = TextStyle(
        fontSize: 24, color: Theme.of(context).colorScheme.onPrimaryContainer);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Container(
          width: LayoutValues.MEDIUM * 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                reps.toString(),
                style: style,
              ),
            ],
          ),
        ),
        if (amount != null && amount != 0)
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Icon(Icons.close_rounded, size: LayoutValues.MEDIUM),
              SizedBox(
                width: LayoutValues.SMALLER,
              ),
              Text(
                amount.toString(),
                style: style,
              ),
              Text(unit.toLowerCase()),
            ],
          ),
      ],
    );
  }

  void _editExercise() async {
    HapticFeedback.mediumImpact();
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return AddExerciseView(
        service: service,
        exercise: this.exercise,
      );
    }));
    setState(() {});
  }

  _confirmExerciseDeletion(BuildContext context) {
    // set up the buttons
    var cancelButton = TextButton(
      child: Text("Nope"),
      style: ButtonStyles.greyButton(context),
      onPressed: () => Navigator.of(context).pop(false),
    );

    var continueButton = TextButton(
        child: Text("Yes"),
        style: ButtonStyles.dangerButton(context),
        onPressed: () => Navigator.of(context).pop(true));
    // set up the AlertDialog
    var alert = AlertDialog(
      title: Text("Delete Exercise?"),
      content: Text("You will not be able to undo this"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    ).then((value) async {
      if (value) {
        await this.service.deleteExercise(this.exercise?.id);
        Navigator.of(context).pop("DELETE");
      }
    });
  }
}
