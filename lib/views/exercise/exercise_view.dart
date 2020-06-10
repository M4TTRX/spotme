import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_workouts/model/exercise_model.dart';
import 'package:home_workouts/model/exercise_set.dart';
import 'package:home_workouts/service/service.dart';
import 'package:home_workouts/views/exercise/sets_list_view.dart';
import 'package:home_workouts/views/shared/padding.dart';
import 'package:home_workouts/views/shared/scroll_behavior.dart';
import 'package:home_workouts/views/shared/text/headings.dart';
import 'package:uuid/uuid.dart';

class ExerciseView extends StatefulWidget {
  final Exercise exercise;
  ExerciseView({this.exercise});

  @override
  _ExerciseViewState createState() => _ExerciseViewState(exercise);
}

class _ExerciseViewState extends State<ExerciseView> {
  _ExerciseViewState(this.exercise);

  // Can be use to implement default vallues in text fields
  Exercise exercise;

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
    exercise = exercise ?? Exercise(type: "", unit: "", sets: [ExerciseSet()]);
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
                Text( exercise.type.toUpperCase() ?? "",
                  style: TextStyle(
                    fontSize: 28,
                    fontFamily: "Red Hat Text",
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                _displaySets(exercise),
                SizedBox(
                  height: 32,
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 10, top: 4),
                      child: Icon(
                        Icons.event_available,
                        size: 29,
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
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "Now",
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
                                  .then((date) => exercise.createDate);
                            },
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 14, top: 4),
                      child: Icon(
                        Icons.straighten,
                        size: 29,
                        color: Colors.indigo,
                      ),
                    ),
                    Flexible(
                      child: Text( exercise.unit ?? "",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
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
                        color: Colors.indigo,
                      ),
                    ),
                    Flexible(
                      child: TextFormField(
                        enabled: false,
                        keyboardType: TextInputType.multiline,
                        maxLines: 10,
                        initialValue: exercise.unit ?? "",
                        validator: (val) => val.isEmpty ? "Invalid name" : null,
                        style: TextStyle(
                          fontSize: 18,
                        ),
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
                ),
              ],
            ),
          )
        ],
      ),
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
            size: 29,
            color: Colors.indigo,
          ),
        ),
       SetsView(sets: exercise.sets),
      ],
    );
  }
}
