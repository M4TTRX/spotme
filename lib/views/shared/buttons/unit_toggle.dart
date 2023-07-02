import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:spotme/theme/layout_values.dart';

import '../../../model/exercise_model.dart';
import '../units.dart';

class UnitSelect extends StatefulWidget {
  UnitSelect(Exercise this.exercise, bool this.displayLabel, {super.key});
  Exercise exercise;
  bool displayLabel;
  @override
  State<UnitSelect> createState() =>
      _UnitSelectState(this.exercise, displayLabel);
}

class _UnitSelectState extends State<UnitSelect> {
  _UnitSelectState(Exercise this._exercise, bool this._displayLabel);
  Exercise _exercise;
  bool _displayLabel;
  List<bool> _selections = [true, false];

  @override
  Widget build(BuildContext context) {
    if (_exercise.unit == null) {
      _exercise.unit = Unit.KG.getString();
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _displayLabel
          ? Text(
              "Unit",
              style: Theme.of(context).textTheme.bodyText2,
            )
          : Container(),
      ToggleButtons(
        isSelected: _selections,
        borderRadius: BorderRadius.circular(LayoutValues.SMALL),
        children: [
          Text(
            Unit.KG.getString(),
            style: Theme.of(context).textTheme.button,
          ),
          Text(
            Unit.LBS.getString(),
            style: Theme.of(context).textTheme.button,
          )
        ],
        onPressed: (pressedIndex) => setState(() {
          HapticFeedback.lightImpact();
          _selections = List.generate(2, (index) => index == pressedIndex);
          if (pressedIndex == 1) {
            _exercise.unit = Unit.LBS.getString();
            return;
          }
          _exercise.unit = Unit.KG.getString();
        }),
        fillColor: Theme.of(context).colorScheme.surface,
      )
    ]);
  }
}
