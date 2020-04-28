import 'package:flutter/material.dart';
import 'package:home_workouts/helpers/date_time_helper.dart';

import 'package:home_workouts/service/auth_service.dart';
import 'package:home_workouts/service/service.dart';

import 'package:home_workouts/views/shared/scroll_behavior.dart';
import 'package:home_workouts/views/shared/text/subtitle.dart';
import 'package:home_workouts/views/shared/text/title.dart';
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
    var homeViewBody = List<Widget>();
    homeViewBody.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: TitleText("Activity"),
      ),
    );
    DateTime currDay = DateTime(0, 0, 0, 0);
    for (var exercise in data) {
      if (!isSameDay(currDay, exercise.createDate)) {
        homeViewBody.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: SubtitleText(toPrettyString(exercise.createDate)),
          ),
        );
        currDay = exercise.createDate;
      }
      homeViewBody.add(
        Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SimpleText(exercise.type),
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
      homeViewBody.add(Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Divider(
            color: Colors.black,
          )));
    }

    // Return in Listview
    return ScrollConfiguration(
      behavior: BasicScrollBehaviour(),
      child: ListView(
        padding: containerPadding,
        children: homeViewBody,
      ),
    );
  }
}
