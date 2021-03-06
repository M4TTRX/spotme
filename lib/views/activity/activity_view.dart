import 'package:flutter/material.dart';
import 'package:home_workouts/helpers/date_time_helper.dart';
import 'package:home_workouts/model/account_model.dart';
import 'package:home_workouts/model/exercise_set.dart';

import 'package:home_workouts/service/service.dart';
import 'package:home_workouts/views/exercise/exercise_view.dart';
import 'package:home_workouts/views/shared/loading_view.dart';

import 'package:home_workouts/views/shared/scroll_behavior.dart';
import 'package:home_workouts/views/shared/text/headings.dart';
import 'package:home_workouts/views/shared/text/simple_text.dart';

import 'package:home_workouts/model/exercise_model.dart';
import 'package:home_workouts/views/shared/padding.dart';
import 'package:home_workouts/views/shared/whitespace.dart';

class ActivityView extends StatefulWidget {
  final AppService service;
  ActivityView({required this.service});

  @override
  _ActivityViewState createState() => _ActivityViewState(service);
}

class _ActivityViewState extends State<ActivityView> {
  _ActivityViewState(this.service);
  AppService service;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: service.exerciseDataStream,
      builder: (context, snapshot) {
        return _buildActivityBody(snapshot.data as List<Exercise>?);
      },
    );
  }

  Widget _buildActivityBody(List<Exercise>? data) {
    if (data == null || data.length == 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 1,
            child: Text(
              "You have no activity! \n WTF bro! STOP SLACKING! START GRINDING!",
              style: TextStyle(
                fontSize: 28,
                fontFamily: "Red Hat Text",
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
    }
    // Generate list of cards
    List<Widget> activityViewBody = [];
    DateTime? currDay = DateTime(0, 0, 0, 0);
    for (var exercise in data) {
      if (!isSameDay(currDay!, exercise.createDate!)) {
        activityViewBody.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 1.0),
            child: Heading1(
              toPrettyString(exercise.createDate!),
              color: Colors.indigo,
            ),
          ),
        );
        activityViewBody.add(Divider(
          thickness: 2,
          height: 16,
        ));
        currDay = exercise.createDate;
      }
      activityViewBody.add(Container(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: InkWell(
          onTap: () {
            Navigator.of(this.context)
                .push(MaterialPageRoute(builder: (context) {
              return ExerciseView(
                service: service,
                exercise: exercise,
              );
            }));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Body(
                exercise.type!.toUpperCase(),
              ),
              WhiteSpace(),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                color: Colors.grey[200],
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SimpleText(exercise.getDisplayAmount()),
                ),
              ),
            ],
          ),
        ),
      ));
    }

    activityViewBody.add(SizedBox(
      height: 128,
    ));

    // Return in Listview
    return ScrollConfiguration(
      behavior: BasicScrollBehaviour(),
      child: ListView(
        padding: containerPadding,
        children: activityViewBody,
      ),
    );
  }
}
