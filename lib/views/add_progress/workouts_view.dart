import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
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
  Exercise? exercise;

  @override
  State<WorkoutList> createState() => _WorkoutListState();
}

class _WorkoutListState extends State<WorkoutList> {
  int? _value = 1;
  WorkoutColor? _color = WorkoutColor.PRIMARY;

  List<Widget> _workoutsChipList() {
    var workoutChips = List<Widget>.generate(
      2,
      (int index) {
        return Padding(
          padding: const EdgeInsets.only(left: LayoutValues.SMALL),
          child: ChoiceChip(
            label: Text('Workout $index'),
            selected: _value == index,
            onSelected: (bool selected) {
              setState(() {
                _value = selected ? index : null;
              });
            },
          ),
        );
      },
    ).toList();
    ActionChip actionChip = ActionChip(
        label: Text('Add Workout'),
        avatar: Icon(Icons.add),
        onPressed: _addWorkoutModal);
    workoutChips.add(Padding(
      padding: const EdgeInsets.only(left: LayoutValues.SMALL),
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
    showCupertinoModalBottomSheet(
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _workoutsChipList(),
          ),
        ),
      ],
    );
  }
}
