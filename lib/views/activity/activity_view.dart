import 'package:flutter/material.dart';
import 'package:home_workouts/helpers/date_time_helper.dart';

import 'package:home_workouts/service/service.dart';

import 'package:home_workouts/views/shared/scroll_behavior.dart';
import 'package:home_workouts/views/shared/text/headings.dart';
import 'package:home_workouts/views/shared/text/simple_text.dart';

import 'package:home_workouts/model/exercise_model.dart';
import 'package:home_workouts/views/shared/padding.dart';
import 'package:home_workouts/views/shared/whitespace.dart';

class ActivityView extends StatefulWidget {
  @override
  _ActivityViewState createState() => _ActivityViewState();
}

class _ActivityViewState extends State<ActivityView> {
  AppService service = AppService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: service.exerciseDataStream,
      builder: (context, snapshot) {
        return _buildActivityBody(snapshot.data);
      },
    );
  }

  Widget _buildActivityBody(List<Exercise> data) {
    if (data == null) {
      return Container();
    }
    // Generate list of cards
    var activityViewBody = List<Widget>();
    DateTime currDay = DateTime(0, 0, 0, 0);
    for (var exercise in data) {
      if (!isSameDay(currDay, exercise.createDate)) {
        activityViewBody.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 1.0),
            child: Heading1(
              toPrettyString(exercise.createDate),
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
      activityViewBody.add(
        Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Body(
                  exercise.type,
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
                      child: SimpleText((exercise.amount).toInt().toString()),
                    ))
              ],
            )),
      );
    }

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
