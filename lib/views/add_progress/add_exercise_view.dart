import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:spotme/helpers/date_time_helper.dart';
import 'package:spotme/helpers/string_helper.dart';
import 'package:spotme/model/exercise_model.dart';
import 'package:spotme/model/exercise_set.dart';
import 'package:spotme/service/service.dart';
import 'package:spotme/theme/layout_values.dart';
import 'package:spotme/theme/theme_Data.dart';
import 'package:spotme/views/add_progress/workouts_view.dart';
import 'package:spotme/views/shared/padding.dart';
import 'package:uuid/uuid.dart';

import '../shared/buttons/unit_toggle.dart';
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
  String? _exerciseID;
  int? selectedIndex;
  String currentBuildType = "default";
  @override
  Widget build(BuildContext context) {
    if (exercise == null) {
      this.exercise = Exercise(sets: [ExerciseSet(repetitions: 1)]);
    } else {
      _exerciseID = exercise!.id;
    }

    // Update exercise cache so that recommendations work right away
    service.updateExerciseCache();
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
                    await service.putExercise(exercise!,
                        exerciseId: _exerciseID);
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
    exercise = exercise ??
        Exercise(
          type: "",
          unit: "",
          sets: [ExerciseSet()],
          createDate: DateTime.now(),
        );

    var typeTextFieldController = TextEditingController();
    typeTextFieldController.text = this.exercise!.type ?? "";

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
                    TypeAheadFormField(
                      textFieldConfiguration: TextFieldConfiguration(
                          // autofocus exercise name if it is empty
                          autofocus: (this.exercise?.type?.length ?? 0) > 0,
                          style: Theme.of(context).textTheme.bodyText2,
                          controller: typeTextFieldController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Exercise Name",
                          )),
                      suggestionsCallback: (pattern) async {
                        this.exercise!.type = pattern;
                        return service.searchExercise(pattern);
                      },
                      minCharsForSuggestions: 1,
                      itemBuilder: (context, suggestion) {
                        if (suggestion == null || suggestion.type == null) {
                          return Container();
                        }
                        return Container(
                          padding: containerPadding,
                          height: LayoutValues.EVEN_LARGER,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                suggestion.type.capitalize() ??
                                    "Unknown exercise",
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              Text(
                                suggestion.getDisplayAmount(),
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ],
                          ),
                        );
                      },
                      onSuggestionSelected: (suggestion) {
                        setState(() {
                          try {
                            // use the data from previous exercise to pre-load most thing                            newExercise.createDate = DateTime.now();
                            this.exercise!.sets = suggestion.sets;
                            this.exercise!.type = suggestion.type.capitalize();
                            typeTextFieldController.text =
                                suggestion.type ?? "Error";

                            if (suggestion.workout != null &&
                                this.exercise!.workout == null) {
                              this.exercise!.workout = suggestion.workout;
                            }
                            this.exercise!.unit = suggestion.unit;
                            this.currentBuildType =
                                "prefilled_" + (this.exercise!.type ?? "");
                          } catch (e) {
                            print(
                                "Error, suggestion is not an exercise: $suggestion");
                          }
                        });
                      },
                      validator: (val) => val!.isEmpty ? "Invalid name" : null,
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
                  SizedBox(
                    height: LayoutValues.SMALL,
                  ),
                  Text(
                    "Other Properties",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  SizedBox(
                    height: LayoutValues.SMALL,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Date",
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          Container(
                              key: Key(Uuid().v4()),
                              height: LayoutValues.EVEN_LARGER + 2,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                  ),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(LayoutValues.SMALL))),
                              child: MaterialButton(
                                padding: EdgeInsets.all(LayoutValues.SMALL),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.event_available,
                                      size: 29,
                                    ),
                                    SizedBox(
                                      width: LayoutValues.SMALL,
                                    ),
                                    Text(
                                      exercise!.createDate == null
                                          ? "Today"
                                          : toPrettyString(
                                              exercise!.createDate!),
                                      overflow: TextOverflow.ellipsis,
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
                        ],
                      ),
                      UnitSelect(
                        exercise!,
                        true,
                      )
                    ],
                  ),
                  Container(
                    height: LayoutValues.LARGE,
                  ),
                  Text(
                    "Notes",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Container(
                    height: 8,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    initialValue: exercise!.notes ?? "",
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
    return AddSetsView(exercise.sets, Key(this.currentBuildType));
  }
}
