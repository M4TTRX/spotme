import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../model/workout_model.dart';
import '../../theme/layout_values.dart';

class AddWorkoutView extends StatefulWidget {
  AddWorkoutView({super.key, required this.workout});
  Workout workout;
  @override
  State<AddWorkoutView> createState() => _AddWorkoutViewState();
}

class _AddWorkoutViewState extends State<AddWorkoutView> {
  WorkoutColor? _color = WorkoutColor.PRIMARY;
  _colorRadio() => List<Widget>.generate(4, (int index) {
        return Radio(
            value: WorkoutColor.values[index],
            groupValue: _color,
            onChanged: (value) {
              setState(() {
                _color = value;
              });
            });
      }).toList();
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
          margin: EdgeInsets.fromLTRB(LayoutValues.MEDIUM, LayoutValues.LARGE,
              LayoutValues.MEDIUM, LayoutValues.LARGEST),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "New Workout",
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: LayoutValues.SMALL),
              Text(
                "Workout Name",
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(height: LayoutValues.SMALL),
              TextField(
                decoration: InputDecoration(
                  hintText: "Workout Name",
                ),
              ),
              SizedBox(height: LayoutValues.SMALL),
              Text(
                "Workout Color",
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(height: LayoutValues.SMALL),
              Row(
                children: _colorRadio(),
              ),
            ],
          )),
    );
  }
}
