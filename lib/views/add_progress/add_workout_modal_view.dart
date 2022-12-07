import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../model/workout_model.dart';
import '../../theme/layout_values.dart';
import '../shared/buttons/buttonStyles.dart';

class AddWorkoutView extends StatefulWidget {
  AddWorkoutView({super.key, required this.workout});
  Workout workout;
  @override
  State<AddWorkoutView> createState() => _AddWorkoutViewState(workout);
}

class _AddWorkoutViewState extends State<AddWorkoutView> {
  _AddWorkoutViewState(this._workout);
  WorkoutColor _color = WorkoutColor.PRIMARY;
  Workout _workout;

  _colorRadio() => List<Widget>.generate(6, (int index) {
        return Radio(
          value: WorkoutColor.values[index],
          groupValue: _color,
          fillColor: WorkoutColor.values[index].getColor(),
          onChanged: (value) {
            setState(() {
              if (value != null) {
                _color = value;
              }
            });
          },
          visualDensity: VisualDensity.compact,
        );
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
                style: Theme.of(context).textTheme.headline3,
              ),
              SizedBox(height: LayoutValues.LARGE),
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
              SizedBox(height: LayoutValues.MEDIUM),
              Text(
                "Workout Color",
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(height: LayoutValues.SMALL),
              Row(
                children: _colorRadio(),
              ),
              SizedBox(height: LayoutValues.MEDIUM),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: Text("Cancel"),
                    style: ButtonStyles.greyButton(context),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: LayoutValues.SMALL),
                  TextButton(
                    child: Text("Submit"),
                    style: ButtonStyles.actionButton(context),
                    onPressed: () {
                      this._workout.color = this._color ?? WorkoutColor.NEUTRAL;
                      Navigator.pop(context);
                    },
                  )
                ],
              )
            ],
          )),
    );
  }
}
