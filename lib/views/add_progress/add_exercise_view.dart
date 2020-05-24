import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_workouts/model/exercise_model.dart';
import 'package:home_workouts/model/exercise_set.dart';
import 'package:home_workouts/service/service.dart';
import 'package:home_workouts/views/add_progress/sets_list_view.dart';
import 'package:home_workouts/views/shared/padding.dart';
import 'package:home_workouts/views/shared/scroll_behavior.dart';
import 'package:home_workouts/views/shared/text/headings.dart';
import 'package:uuid/uuid.dart';

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
                TextFormField(
                  initialValue: exercise.type ?? "",
                  validator: (val) => val.isEmpty ? "Invalid name" : null,
                  style: TextStyle(
                    fontSize: 28,
                    fontFamily: "Red Hat Text",
                  ),
                  decoration: InputDecoration(
                    hintText: "Exercise name",
                    border: InputBorder.none,
                  ),
                  onChanged: (val) {
                    setState(() => exercise.type = val);
                  },
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
                      child: TextFormField(
                        initialValue: exercise.unit ?? "",
                        validator: (val) => val.isEmpty ? "Invalid name" : null,
                        style: TextStyle(
                          fontSize: 18,
                        ),
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
    var sets = List<Widget>();
    if (exercise.sets != null) {
      for (int i = 0; i < exercise.sets.length; i++) {
        sets.add(Row(mainAxisSize: MainAxisSize.max, children: [
          Container(
            key: Key(Uuid().v4()),
            width: 96,
            child: TextFormField(
              keyboardType: TextInputType.number,
              initialValue: exercise.sets[i].amount == null
                  ? ""
                  : exercise.sets[i].amount.toStringAsFixed(1),
              validator: (val) => val.isEmpty ? "Invalid value" : null,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                hintText: "Amount",
                hintStyle:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                border: InputBorder.none,
              ),
              onChanged: (val) {
                exercise.sets[i].amount = double.parse(val);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: Icon(
              Icons.clear,
              size: 28,
            ),
          ),
          Container(
            width: 96,
            child: TextFormField(
              keyboardType: TextInputType.number,
              initialValue: exercise.sets[i].repetitions == null
                  ? ""
                  : exercise.sets[i].repetitions.toString(),
              validator: (val) => val.isEmpty ? "Invalid value" : null,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                hintText: "Sets",
                border: InputBorder.none,
              ),
              onChanged: (val) {
                exercise.sets[i].repetitions = int.parse(val);
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.clear),
            color: Color(0xFFEF4646),
            iconSize: 22,
            onPressed: () {
              setState(() => exercise.sets.removeAt(i));
            },
          )
        ]));
      }
    }
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
        AddSetsView(sets: exercise.sets),
      ],
    );
  }
}
