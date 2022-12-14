import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:spotme/helpers/color_helpers.dart';
import 'package:spotme/model/exercise_model.dart';
import 'package:spotme/model/workout_model.dart';
import 'package:spotme/service/service.dart';
import 'package:spotme/theme/theme_Data.dart';
import 'package:uuid/uuid.dart';

import '../../theme/layout_values.dart';
import 'add_workout_modal_view.dart';

class WorkoutList extends StatefulWidget {
  WorkoutList({super.key, required this.service, required this.exercise});
  final AppService service;
  Exercise exercise;

  @override
  State<WorkoutList> createState() => _WorkoutListState(exercise, service);
}

class _WorkoutListState extends State<WorkoutList> {
  _WorkoutListState(this.exercise, this.service);
  Exercise exercise;
  final AppService service;
  WorkoutColor? _color = WorkoutColor.PRIMARY;

  List<Widget> _workoutsChipList(workoutList) {
    var workoutChips = List<Widget>.generate(
      workoutList.length,
      (int index) {
        return Padding(
          padding: EdgeInsets.only(
              left: index == 0 ? LayoutValues.MEDIUM : LayoutValues.SMALL),
          child: RawChip(
            pressElevation: 0,
            checkmarkColor:
                WorkoutColorHelpers.getColor(workoutList[index].color)
                    .darken(0.5),
            label: Text(workoutList[index].name),
            labelStyle: TextStyle(
                color: WorkoutColorHelpers.getColor(workoutList[index].color)
                    .darken(0.5)),
            backgroundColor:
                WorkoutColorHelpers.getColor(workoutList[index].color)
                    .withAlpha(64),
            selectedColor:
                WorkoutColorHelpers.getColor(workoutList[index].color)
                    .withAlpha(196),
            selected: exercise.workout == workoutList[index],
            side: BorderSide(style: BorderStyle.none),
            onSelected: (bool selected) {
              setState(() {
                exercise.workout = selected ? workoutList[index] : null;
              });
            },
          ),
        );
      },
    ).toList();
    RawChip actionChip = RawChip(
      pressElevation: 0,
      label: Text('Add Workout'),
      avatar: Icon(Icons.add),
      backgroundColor: Theme.of(context).colorScheme.surface,
      side: BorderSide(style: BorderStyle.none),
      onPressed: _addWorkoutModal,
    );
    workoutChips.add(Padding(
      padding: const EdgeInsets.only(
        left: LayoutValues.SMALL,
        right: LayoutValues.MEDIUM,
      ),
      child: actionChip,
    ));
    return workoutChips;
  }

  void _addWorkoutModal() {
    Workout _newWorkout = Workout(Uuid().v4().toString(), "", "");
    // create the list of colors associated to a radio button
    var _colorRadio = List<Widget>.generate(4, (int index) {
      return Radio(
          value: WorkoutColor.values[index],
          groupValue: this._color,
          onChanged: (value) {
            this._color = value;
            setState(() {});
          });
    }).toList();
    showBarModalBottomSheet(
      context: context,
      builder: ((context) => Material(
            type: MaterialType.transparency,
            child: AddWorkoutView(
              workout: _newWorkout,
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: service.userWorkoutStream,
        initialData: [],
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Container();
          }
          return Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _workoutsChipList(snapshot.data as List<Workout>),
                ),
              ),
            ],
          ));
        });
  }
}
