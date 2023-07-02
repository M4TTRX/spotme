import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:spotme/helpers/string_helper.dart';
import 'package:spotme/service/service.dart';
import 'package:spotme/views/shared/whitespace.dart';
import 'package:spotme/views/shared/workout_chip.dart';
import 'package:spring_button/spring_button.dart';

import '../../../model/exercise_model.dart';
import '../../../model/workout_model.dart';
import '../../../theme/layout_values.dart';
import '../../add_progress/add_exercise_view.dart';

class RecommendedExerciseCard extends StatefulWidget {
  const RecommendedExerciseCard(Exercise this.exercise, AppService this.service,
      {super.key});
  final Exercise exercise;
  final AppService service;

  @override
  State<RecommendedExerciseCard> createState() =>
      _RecommendedExerciseCardState();
}

class _RecommendedExerciseCardState extends State<RecommendedExerciseCard> {
  @override
  Widget build(BuildContext context) {
    return SpringButton(
      SpringButtonType.WithOpacity,
      Container(
        margin: EdgeInsets.only(
          right: LayoutValues.MEDIUM,
        ),
        height: LayoutValues.CARD_HEIGHT,
        width: LayoutValues.CARD_WIDTH,
        decoration: new BoxDecoration(
          color: getColor(context),
          borderRadius: BorderRadius.circular(LayoutValues.MEDIUM),
          // boxShadow: [LayoutValues.CARD_SHADOW],
        ),
        child: Padding(
          padding: LayoutValues.CARD_PADDING,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                this.widget.exercise.type?.capitalize() ?? "Exercise",
                style: Theme.of(context).textTheme.headline2,
              ),
              Text(
                this.widget.exercise.getDisplayAmount(),
                style: Theme.of(context).textTheme.bodyText2,
              ),
              WhiteSpace(),
              (widget.exercise.workout != null)
                  ? WorkoutChip(this.widget.exercise.workout!)
                  : Container()
            ],
          ),
        ),
      ),
      scaleCoefficient: 0.4,
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return AddExerciseView(
            exercise: widget.exercise,
            service: widget.service,
          );
        }));
      },
    );
  }

  Color getColor(BuildContext context) {
    if (widget.exercise.workout != null) {
      return WorkoutColorHelpers.getColor(widget.exercise.workout!.color)
          .withAlpha(48);
    }
    return Theme.of(context).colorScheme.surfaceVariant;
  }
}
