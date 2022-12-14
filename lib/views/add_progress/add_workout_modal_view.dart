import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../model/account_model.dart';
import '../../model/workout_model.dart';
import '../../service/service.dart';
import '../../theme/layout_values.dart';
import '../shared/buttons/buttonStyles.dart';

class AddWorkoutView extends StatefulWidget {
  AddWorkoutView({super.key, this.workout});
  Workout? workout;
  @override
  State<AddWorkoutView> createState() => _AddWorkoutViewState(workout);
}

class _AddWorkoutViewState extends State<AddWorkoutView> {
  _AddWorkoutViewState(this._workout);
  final _formKey = GlobalKey<FormState>();

  WorkoutColor _color = WorkoutColor.PRIMARY;
  Workout? _workout;
  String _name = "";
  late AppService service;

  _colorRadio() =>
      List<Widget>.generate(WorkoutColor.values.length, (int index) {
        return Radio(
          value: WorkoutColor.values[index],
          groupValue: _color,
          fillColor: MaterialStateProperty.all<Color>(
              WorkoutColorHelpers.getColor(WorkoutColor.values[index])),
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
    return Consumer<Account>(
        builder: (context, Account account, Widget? widget) {
      this.service = AppService(account: account);
      return Material(
        type: MaterialType.transparency,
        child: Form(
          key: _formKey,
          child: Container(
              margin: EdgeInsets.fromLTRB(
                  LayoutValues.MEDIUM,
                  LayoutValues.LARGE,
                  LayoutValues.MEDIUM,
                  LayoutValues.LARGEST),
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
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Workout Name",
                    ),
                    validator: (value) {
                      if (value == null || value.length <= 0)
                        return "Workout must have a name";
                      if (value.length > 20)
                        return "Workout name should be 20 characters max";
                      return null;
                    },
                    onChanged: (String val) {
                      _name = val;
                    },
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
                          HapticFeedback.selectionClick();
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(width: LayoutValues.SMALL),
                      TextButton(
                        child: Text("Submit"),
                        style: ButtonStyles.actionButton(context),
                        onPressed: () {
                          HapticFeedback.selectionClick();
                          if (_formKey.currentState!.validate()) {
                            this
                                .service
                                .putWorkout(Uuid().v4(), this._name, _color);
                            Navigator.pop(context);
                          } else {
                            HapticFeedback.heavyImpact();
                          }
                   
                        },
                      )
                    ],
                  )
                ],
              )),
        ),
      );
    });
  }
}
