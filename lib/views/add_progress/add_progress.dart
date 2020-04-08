import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_workouts/model/home_model.dart';
import 'package:home_workouts/service/service.dart';

class AddProgressView extends StatefulWidget {
  AddProgressView({Key key}) : super(key: key);
  @override
  _AddProgressViewState createState() => _AddProgressViewState();
}

class _AddProgressViewState extends State<AddProgressView> {
  AppService service = AppService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            HapticFeedback.lightImpact();
          },
          label: new Text("Log new exercise", style: TextStyle(fontSize: 16))),
      body: StreamBuilder<Object>(
        stream: service.HomeViewDataStream,
        builder: (context, snapchot) {
          return _buildHomeBody(snapchot.data);
        },
      ),
    );
  }

  Widget _buildHomeBody(HomeViewData data) {
    // Return in listview
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
    );
  }
}
