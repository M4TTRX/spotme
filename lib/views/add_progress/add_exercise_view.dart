import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_workouts/helpers/date_time_helper.dart';
import 'package:home_workouts/model/exercise_model.dart';
import 'package:home_workouts/model/exercise_set.dart';
import 'package:home_workouts/service/service.dart';
import 'package:home_workouts/views/shared/padding.dart';
import 'package:home_workouts/views/shared/scroll_behavior.dart';
import 'package:home_workouts/views/shared/text/headings.dart';
import 'package:uuid/uuid.dart';

import 'add_sets_list_view.dart';

class AddExerciseView extends StatefulWidget {
  final Exercise exercise;
  AddExerciseView({this.exercise});

  @override
  _AddExerciseViewState createState() => _AddExerciseViewState(exercise);
}

class _AddExerciseViewState extends State<AddExerciseView> {
  _AddExerciseViewState(this.exercise);

  // Can be use to implement default vallues in text fields
  Exercise exercise;

  final double _iconSize = 29;

  final TextStyle _textFieldTextStyle = TextStyle(fontSize: 18);
  // Form Key used to validate the form input
  final _formKey = GlobalKey<FormState>();

  // service will help us update the exercise in the cloud
  final AppService _service = AppService();

  int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      backgroundColor: Colors.white,
      floatingActionButton: Container(
        height: 56,
        child: FloatingActionButton.extended(
          autofocus: false,
          label: Heading1("Submit"),
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              await _service.putExercise(exercise);
              Navigator.pop(context);
            } else {
              HapticFeedback.heavyImpact();
            }
          },
          icon: Icon(
            Icons.add,
            size: 32,
            color: Colors.indigo,
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    exercise = exercise ??
        Exercise(
            type: "", unit: "", sets: [ExerciseSet()], usesBodyWeight: false);
    return ScrollConfiguration(
      behavior: BasicScrollBehaviour(),
      child: ListView(
        padding: containerPadding,
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _getExerciseNameFields(),
                SizedBox(
                  height: 32,
                ),
                _getUnitAndTimeFields(),
                SizedBox(
                  height: 8,
                ),
                _getBodyWeightToggle(),
                _displaySets(exercise),
                SizedBox(
                  height: 32,
                ),
                _getNotesField(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _getExerciseNameFields() {
    return TextFormField(
      initialValue: exercise.type ?? "",
      validator: (val) => val.isEmpty ? "Invalid name" : null,
      style: TextStyle(
        fontSize: 32,
        fontFamily: "Red Hat Text",
      ),
      decoration: InputDecoration(
        hintText: "Exercise name",
        border: InputBorder.none,
      ),
      onChanged: (val) {
        setState(() => exercise.type = val);
      },
    );
  }

  Widget _getBodyWeightToggle() {
    return Row(
      children: <Widget>[
        Checkbox(
          value: exercise.usesBodyWeight,
          onChanged: (bool value) {
            setState(() {
              exercise.usesBodyWeight = value;
            });
          },
        ),
        Body("This exercise uses bodyweight")
      ],
    );
  }

  Widget _getUnitAndTimeFields() {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 10, top: 0),
          child: Icon(
            Icons.event_available,
            size: _iconSize,
            color: Colors.indigo,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 24.0 + 28.0),
          child: Container(
              key: Key(Uuid().v4()),
              width: 96,
              child: MaterialButton(
                padding: EdgeInsets.all(4),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                child: Row(
                  children: <Widget>[
                    Text(
                      exercise.createDate == null
                          ? "Today"
                          : toPrettyString(exercise.createDate),
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
                    exercise.createDate = date;
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
            size: _iconSize,
            color: Colors.indigo,
          ),
        ),
        Flexible(
          child: TextFormField(
            initialValue: exercise.unit ?? "",
            style: _textFieldTextStyle,
            decoration: InputDecoration(
              hintText: "Unit",
              border: InputBorder.none,
            ),
            onChanged: (val) {
              setState(() => exercise.unit = val);
            },
          ),
        ),
      ],
    );
  }

  Widget _getNotesField() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 14, top: 9),
          child: Icon(
            Icons.subject,
            size: _iconSize,
            color: Colors.indigo,
          ),
        ),
        Flexible(
          child: TextFormField(
            keyboardType: TextInputType.multiline,
            maxLines: 10,
            initialValue: exercise.unit ?? "",
            style: _textFieldTextStyle,
            decoration: InputDecoration(
              hintText: "Notes",
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
            onChanged: (val) {
              setState(() => exercise.notes = val);
            },
          ),
        ),
      ],
    );
  }

  Widget _displaySets(Exercise exercise) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 14, top: 4),
          child: Icon(
            Icons.subdirectory_arrow_right,
            size: _iconSize,
            color: Colors.indigo,
          ),
        ),
        AddSetsView(sets: exercise.sets),
      ],
    );
  }
}
