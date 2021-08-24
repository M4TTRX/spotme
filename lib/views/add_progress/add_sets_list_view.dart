import 'package:flutter/material.dart';
import 'package:home_workouts/model/exercise_set.dart';
import 'package:uuid/uuid.dart';

class AddSetsView extends StatefulWidget {
  final List<ExerciseSet>? sets;
  AddSetsView({this.sets});
  @override
  _AddSetsViewState createState() => _AddSetsViewState(sets ?? []);
}

class _AddSetsViewState extends State<AddSetsView> {
  _AddSetsViewState(this.sets);

  final List<ExerciseSet> sets;

  // Animated List Key used to update the state of the list
  final _animatedListKey = GlobalKey<AnimatedListState>();

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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 130,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    initialValue: sets[i].repetitions == null
                        ? ""
                        : sets[i].repetitions.toString(),
                    validator: (val) => val!.isEmpty ? "Invalid value" : null,
                    style: Theme.of(context).textTheme.headline4,
                    onChanged: (val) {
                      sets[i].repetitions = int.parse(val);
                    },
                  ),
                ),

                Container(
                  width: 48,
                ),
                Container(
                  width: 96,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    initialValue: sets[i].amount == null
                        ? ""
                        : sets[i].amount!.toStringAsFixed(1),
                    validator: (val) => val!.isEmpty ? "Invalid value" : null,
                    style: Theme.of(context).textTheme.headline4,
                    onChanged: (val) {
                      sets[i].amount = double.parse(val);
                    },
                  ),
                ),
                // Display the remove set button if there is more than one set
                sets.length == 1
                    ? Container()
                    : IconButton(
                        icon: Icon(Icons.clear),
                        color: Color(0xFFEF4646),
                        iconSize: 22,
                        onPressed: () {
                          setState(() {
                            sets.removeAt(i);
                          });
                        },
                      )
              ],
            ));

    columnChildren.add(Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            TextButton.icon(
              icon: Icon(Icons.add),
              label: Text(
                "Add set",
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Red Hat Text",
                ),
              ),
              onPressed: () {
                setState(() {
                  var tmpExercise = sets.length > 0
                      ? ExerciseSet(
                          amount: sets.last.amount,
                          repetitions: sets.last.repetitions)
                      : ExerciseSet();
                  sets.add(tmpExercise);
                });
              },
            ),
          ],
        ),
      ),
    ));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: columnChildren,
    );
  }
}
