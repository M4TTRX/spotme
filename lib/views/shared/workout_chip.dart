import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:spotme/helpers/color_helpers.dart';
import 'package:spotme/helpers/string_helper.dart';
import 'package:spotme/theme/layout_values.dart';

import '../../model/workout_model.dart';

class WorkoutChip extends StatelessWidget {
  const WorkoutChip(this.workout, {super.key});
  final Workout workout;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(workout.name.capitalize(),
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: WorkoutColorHelpers.getColor(workout.color)
                  .darken(LayoutValues.WORKOUT_CHIP_TEXT_DARKEN))),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(LayoutValues.MEDIUM),
          color: WorkoutColorHelpers.getColor(workout.color)
              .withAlpha(LayoutValues.WORKOUT_CHIP_BACKGROUND_ALPHA)),

      padding: EdgeInsets.fromLTRB(LayoutValues.SMALL, LayoutValues.SMALLEST,
          LayoutValues.SMALL, LayoutValues.SMALLEST),
      // side: BorderSide(style: BorderStyle.none),
    );
  }
}
