import 'package:flutter/material.dart';
import 'package:home_workouts/model/exercise_set.dart';
import 'package:uuid/uuid.dart';

class SetsView extends StatefulWidget {
  final List<ExerciseSet>? sets;
  SetsView({this.sets});
  @override
  _SetsViewState createState() => _SetsViewState(sets ?? []);
}

class _SetsViewState extends State<SetsView> {
  _SetsViewState(this.sets);

  final List<ExerciseSet> sets;

  final _rowHeight = 96.0;
  @override
  Widget build(
    BuildContext context,
  ) {
    List<Widget> columnChildren = List.generate(
        sets.length,
        (i) => Row(
              key: Key(Uuid().v4()),
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 96,
                  child: Text( sets[i].amount == null
                        ? ""
                        : sets[i].amount!.toStringAsFixed(1),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
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
                  child: Text( sets[i].repetitions == null
                        ? ""
                        : sets[i].repetitions.toString(),
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: columnChildren,
    );
  }
}
