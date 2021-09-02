import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_workouts/helpers/date_time_helper.dart';
import 'package:home_workouts/model/exercise_model.dart';
import 'package:home_workouts/model/exercise_set.dart';
import 'package:home_workouts/service/service.dart';
import 'package:home_workouts/theme/layout_values.dart';
import 'package:home_workouts/theme/theme_Data.dart';
import 'package:home_workouts/views/shared/padding.dart';
import 'package:uuid/uuid.dart';

import 'add_sets_list_view.dart';

class AddExerciseView extends StatefulWidget {
  final Exercise? exercise;
  final AppService service;
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
    return ScrollConfiguration(
      behavior: CupertinoScrollBehavior(),
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: Container(
          child: FloatingActionButton.extended(
            autofocus: false,
            label: Text(
              "Submit",
              style: Theme.of(context).textTheme.headline2,
            ),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                await service.putExercise(exercise!);
                Navigator.pop(context);
              } else {
                HapticFeedback.heavyImpact();
              }
            },
            icon: Icon(
              Icons.add,
              size: 32,
            ),
          ),
        ),
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
        SliverAppBar(
          backgroundColor: Colors.transparent,
        ),
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
                  Divider(
                    thickness: DIVIDER_THICKNESS,
                    height: DIVIDER_THICKNESS,
                    color: primaryColor,
                  ),
                  Container(
                    height: 16,
                  ),
                  TextFormField(
                    initialValue: exercise!.type ?? "",
                    validator: (val) => val!.isEmpty ? "Invalid name" : null,
                    textCapitalization: TextCapitalization.sentences,
                    style: Theme.of(context).textTheme.bodyText2,
                    onChanged: (val) {
                      setState(() => exercise!.type = val);
                    },
                  ),
                  SizedBox(
                    height: WHITESPACE_LARGE,
                  ),
                  Text(
                    "Repetitions & Weight",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Divider(
                    thickness: DIVIDER_THICKNESS,
                    height: DIVIDER_THICKNESS,
                    color: primaryColor,
                  ),
                ]),
          )
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
                  Divider(
                    thickness: DIVIDER_THICKNESS,
                    height: 1,
                    color: primaryColor,
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
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: WHITESPACE_LARGE + 28.0),
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
                        ),
                      ),
                      Flexible(
                        child: TextFormField(
                          initialValue: exercise!.unit ?? "",
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
                    height: WHITESPACE_SMALL,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 14, top: 9),
                        child: Icon(
                          Icons.subject,
                          size: 29,
                        ),
                      ),
                      Flexible(
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 10,
                          initialValue: exercise!.unit ?? "",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          decoration: InputDecoration(
                            hintText: "Notes",
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          ),
                          onChanged: (val) {
                            setState(() => exercise!.notes = val);
                          },
                        ),
                      ),
                    ],
                  ),
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
