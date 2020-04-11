import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_workouts/model/exercise_model.dart';
import 'package:home_workouts/service/service.dart';
import 'package:home_workouts/views/shared/buttons/basic_button.dart';
import 'package:home_workouts/views/shared/buttons/primary_button.dart';
import 'package:home_workouts/views/shared/padding.dart';
import 'package:home_workouts/views/shared/scroll_behavior.dart';
import 'package:home_workouts/views/shared/text/headings.dart';
import 'package:home_workouts/views/shared/text/title.dart';
import 'package:home_workouts/views/shared/whitespace.dart';

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
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    exercise = exercise ?? Exercise(amount: 30, type: "", unit: "");
    return Container(
      padding: containerPadding,
      child: Column(
        children: <Widget>[
          Expanded(
            child: ScrollConfiguration(
              behavior: BasicScrollBehaviour(),
              child: ListView(
                children: <Widget>[
                  TitleText("Add an exercise you did"),
                  SizedBox(
                    height: 24,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          initialValue: exercise.type ?? "",
                          validator: (val) =>
                              val.isEmpty ? "Invalid name" : null,
                          decoration: InputDecoration(
                            labelText: "Exercise type",
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
                        SizedBox(
                          height: 48,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            MaterialButton(
                              shape: CircleBorder(),
                              child: Icon(
                                Icons.remove,
                                size: 48,
                              ),
                              onPressed: () {
                                setState(() {
                                  HapticFeedback.lightImpact();
                                  exercise.amount--;
                                });
                              },
                            ),
                            Container(
                              width: 128,
                              child: TextFormField(
                                autovalidate: true,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                controller: TextEditingController(
                                  text: exercise.amount == null
                                      ? ""
                                      : exercise.amount.round().toString(),
                                ),
                                style: TextStyle(
                                  fontSize: 64,
                                  fontFamily: "Red Hat Text",
                                ),
                                validator: (val) =>
                                    val.isEmpty ? "Invalid amount" : null,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                onChanged: (val) {
                                  exercise.amount = double.parse(val);
                                  setState(() {});
                                },
                              ),
                            ),
                            MaterialButton(
                              shape: CircleBorder(),
                              child: Icon(
                                Icons.add,
                                size: 48,
                              ),
                              onPressed: () {
                                setState(() {
                                  HapticFeedback.lightImpact();
                                  exercise.amount++;
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        exercise.unit == null || exercise.unit.isEmpty
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: TitleText(exercise.unit),
                              ),
                        BasicButton(
                            (exercise.unit == null || exercise.unit.isEmpty)
                                ? "Add unit"
                                : "Edit unit", () async {
                          await _showDialog(context);
                          setState(() {});
                        }),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          PrimaryButton("Save", () async {
            if (_formKey.currentState.validate()) {
              await _service.putExercise(exercise);
              Navigator.pop(context);
            } else {
              HapticFeedback.heavyImpact();
            }
          }),
        ],
      ),
    );
  }

  _showDialog(context) async {
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          String _newUnit = "";
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            contentPadding: const EdgeInsets.all(16.0),
            content: Container(
              height: 128,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Heading1(
                    "Put a unit",
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: TextField(
                      autofocus: true,
                      onChanged: (val) {
                        setState(() => _newUnit = val);
                      },
                      decoration: InputDecoration(
                        labelText: "Exercise type",
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    Navigator.pop(context);
                  }),
              FlatButton(
                  child: const Text('Save'),
                  onPressed: () {
                    HapticFeedback.mediumImpact();
                    exercise.unit = _newUnit;
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }
}