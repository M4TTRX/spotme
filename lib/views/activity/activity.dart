import 'package:flutter/material.dart';

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

  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Logout'),
            onPressed: () async {
              await _authService.signOut();
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder<Object>(
        stream: service.exerciseDataStream,
        builder: (context, snapshot) {
          return _buildActivityBody(snapshot.data);
        },
      ),
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
    homeViewBody.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: SubtitleText("Today"),
      ),
    );
    homeViewBody.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SimpleText(data[0].type),
            WhiteSpace(),
            Material(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(7), 
                  right: Radius.circular(7)),
              ),
              color: Colors.grey[200],
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SimpleText((data[0].amount).toInt().toString()),
              )
            )
          ],
        )
      ),
    );
    homeViewBody.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Divider(
          color: Colors.black,
        )
      )
    );

    homeViewBody.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SimpleText(data[1].type),
            WhiteSpace(),
            Material(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(7), 
                  right: Radius.circular(7)),
              ),
              color: Colors.grey[200],
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SimpleText((data[1].amount).toInt().toString()),
              )
            )
          ],
        )
      ),
    );

    homeViewBody.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0)
      )
    );

    // ================ Yesterday ===========
    homeViewBody.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: SubtitleText("Yesterday"),
      ),
    );
    
    homeViewBody.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SimpleText(data[0].type),
            WhiteSpace(),
            Material(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(7), 
                  right: Radius.circular(7)),
              ),
              color: Colors.grey[200],
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SimpleText((data[1].amount).toInt().toString()),
              )
            )
          ],
        )
      ),
    );
    homeViewBody.add(
      Divider(
        color: Colors.black
      )
    );
    
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