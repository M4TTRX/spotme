import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_workouts/model/exercise_model.dart';
import 'package:home_workouts/model/exercise_set.dart';
import 'package:home_workouts/service/service.dart';
import 'package:home_workouts/views/shared/buttons/basic_button.dart';
import 'package:home_workouts/views/shared/buttons/primary_button.dart';
import 'package:home_workouts/views/shared/padding.dart';
import 'package:home_workouts/views/shared/scroll_behavior.dart';
import 'package:home_workouts/views/shared/text/headings.dart';
import 'package:home_workouts/views/shared/text/title.dart';
import 'package:home_workouts/views/shared/white_app_bar.dart';
import 'package:home_workouts/views/shared/whitespace.dart';
import 'package:uuid/uuid.dart';

class AddExerciseView extends StatefulWidget {
  final Exercise exercise;
  AddExerciseView({this.exercise});

  @override
  _AddExerciseViewState createState() => _AddExerciseViewState(exercise);
}

class _AddExerciseViewState extends State<AddExerciseView> {
  _AddExerciseViewState(this.exercise);

  // Form Keys
  final _formKey = GlobalKey<FormState>();

  // service will help us update the exercise in the cloud
  final AppService _service = AppService();

  // Can be use to implement default vallues in text fields
  Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleText("Add Activity"),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            await _service.putExercise(exercise);
            Navigator.pop(context);
          } else {
            HapticFeedback.heavyImpact();
          }
        },
        label: Heading2("Add Exercise"),
        icon: Icon(
          Icons.add,
          size: 32,
          color: Colors.indigo,
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    exercise = exercise ?? Exercise(type: "", unit: "", sets: [ExerciseSet()]);
    return ScrollConfiguration(
      behavior: BasicScrollBehaviour(),
      child: ListView(
        padding: containerPadding,
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: exercise.type ?? "",
                  validator: (val) => val.isEmpty ? "Invalid name" : null,
                  decoration: InputDecoration(
                    labelText: "Name",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(),
                    ),
                  ),
                  onChanged: (val) {
                    setState(() => exercise.type = val);
                  },
                ),
                _displaySets(exercise),
                BasicButton("Add Set", () {
                  setState(() => exercise.sets.add(ExerciseSet()));
                }),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _displaySets(Exercise exercise) {
    var sets = List<Widget>();
    if (exercise.sets != null) {
      for (int i = 0; i < exercise.sets.length; i++) {
        sets.add(Row(children: [
          Container(
            key: Key(Uuid().v4()),
            width: 128,
            child: TextFormField(
              keyboardType: TextInputType.number,
              initialValue: exercise.sets[i].amount == null
                  ? ""
                  : exercise.sets[i].amount.toString(),
              validator: (val) => val.isEmpty ? "Invalid value" : null,
              decoration: InputDecoration(
                labelText: "Amount",
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(),
                ),
              ),
              onChanged: (val) {
                setState(() => exercise.sets[i].amount = double.parse(val));
              },
            ),
          ),
          Icon(Icons.clear),
          Container(
            width: 128,
            child: TextFormField(
              keyboardType: TextInputType.number,
              initialValue: exercise.sets[i].repetitions == null
                  ? ""
                  : exercise.sets[i].repetitions.toString(),
              validator: (val) => val.isEmpty ? "Invalid value" : null,
              decoration: InputDecoration(
                labelText: "Reps",
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(),
                ),
              ),
              onChanged: (val) {
                setState(() => exercise.sets[i].repetitions = int.parse(val));
              },
            ),
          ),
          WhiteSpace(),
          IconButton(
            icon: Icon(Icons.remove_circle_outline),
            onPressed: () {
              setState(() => exercise.sets.removeAt(i));
            },
          )
        ]));
      }
    }
    return Column(
      children: sets,
    );
  }
}
