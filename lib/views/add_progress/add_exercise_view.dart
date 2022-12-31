import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spotme/helpers/date_time_helper.dart';
import 'package:spotme/model/exercise_model.dart';
import 'package:spotme/model/exercise_set.dart';
import 'package:spotme/service/service.dart';
import 'package:spotme/theme/layout_values.dart';
import 'package:spotme/theme/theme_Data.dart';
import 'package:spotme/views/add_progress/workouts_view.dart';
import 'package:spotme/views/shared/padding.dart';
import 'package:uuid/uuid.dart';

import 'add_sets_list_view.dart';

class AddExerciseView extends StatefulWidget {
  final Exercise? exercise;
  final AppService service;

  static const routeName = '/add_exercise';

  AddExerciseView({required this.service, this.exercise});

  @override
  _AddExerciseViewState createState() =>
      _AddExerciseViewState(service, exercise);
}

class _AddExerciseViewState extends State<AddExerciseView> {
  _AddExerciseViewState(this.service, this.exercise);
  final AppService service;

  // Can be use to implement default vallues in text fields
  Exercise? exercise;

  // Form Key used to validate the form input
  final _formKey = GlobalKey<FormState>();

  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    if (exercise == null) {
      this.exercise = Exercise(sets: [ExerciseSet(repetitions: 1)]);
    }
    return ScrollConfiguration(
      behavior: CupertinoScrollBehavior(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                  right: SIDE_PADDING_VALUE, bottom: SIDE_PADDING_VALUE),
              child: TextButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await service.putExercise(exercise!);
                    Navigator.pop(context);
                  } else {
                    HapticFeedback.heavyImpact();
                  }
                },
                child: Text(
                  "Submit",
                ),
              ),
            )
          ],
        ),
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    ScrollController _scrollController =
        PrimaryScrollController.of(context) ?? ScrollController();
    exercise = exercise ?? Exercise(type: "", unit: "", sets: [ExerciseSet()]);
    return Form(
      key: _formKey,
      child: CustomScrollView(controller: _scrollController, slivers: [
        SliverList(
            delegate: SliverChildListDelegate([
          Padding(
            padding: containerPadding,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Add Exercise",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Container(
                    height: 16,
                  ),
                  Text(
                    "Exercise Name",
                    style: Theme.of(context).textTheme.headline1,
                    ),
                  Container(
                    height: 16,
                  ),
                  TextFormField(
                    initialValue: exercise!.type ?? "",
                    validator: (val) => val!.isEmpty ? "Invalid name" : null,
                    textCapitalization: TextCapitalization.sentences,
                    style: Theme.of(context).textTheme.bodyText2,
                    decoration: InputDecoration(
                      hintText: "Exercise Name",
                    ),
                    onChanged: (val) {
                      setState(() => exercise!.type = val);
                    },
                  ),
                  SizedBox(
                    height: LayoutValues.LARGE,
                  ),
                  Text(
                      "Workouts",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Container(
                      height: LayoutValues.SMALL,
                    ),
                  ])),
          WorkoutList(
            service: service,
            exercise: exercise!,
          ),
          Padding(
            padding: containerPadding,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: LayoutValues.LARGE,
                  ),
                  Text(
                    "Repetitions & Weight",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Container(
                    height: LayoutValues.SMALL,
                  ),
                ]),
          ),
        ])),
        _displaySets(exercise!),
        SliverList(
            delegate: SliverChildListDelegate(
          [
            Padding(
              padding: containerPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Other Properties",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 10, top: 0),
                        child: Icon(
                          Icons.event_available,
                          size: 29,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: LayoutValues.LARGE + 28.0),
                        child: Container(
                            key: Key(Uuid().v4()),
                            width: 96,
                            child: MaterialButton(
                              padding: EdgeInsets.all(4),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    exercise!.createDate == null
                                        ? "Today"
                                        : toPrettyString(exercise!.createDate!),
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "Red Hat Text",
                                    ),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(0),
                                        lastDate: DateTime.now())
                                    .then((date) {
                                  exercise!.createDate = date;
                                  setState(() {});
                                });
                                setState(() {});
                              },
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 14, top: 4),
                        child: Icon(
                          Icons.straighten,
                          size: 29,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Flexible(
                        child: TextFormField(
                          initialValue: exercise!.unit?.isEmpty ?? true
                              ? "kg"
                              : exercise!.unit,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          decoration: InputDecoration(
                            hintText: "Unit",
                            border: InputBorder.none,
                          ),
                          onChanged: (val) {
                            setState(() => exercise!.unit = val);
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: LayoutValues.SMALL,
                  ),
                  Text(
                    "Notes",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Container(
                    height: 8,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    initialValue: exercise!.unit ?? "",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      hintText: "Notes",
                    ),
                    onChanged: (val) {
                      setState(() => exercise!.notes = val);
                    },
                  ),
                  Container(
                    height: LayoutValues.LARGEST,
                  )
                ],
              ),
            ),
          ],
        ))
      ]),
    );
  }

  Widget _displaySets(Exercise exercise) {
    return AddSetsView(sets: exercise.sets);
  }
}
