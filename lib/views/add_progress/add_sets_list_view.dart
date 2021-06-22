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
              children: [
                Container(
                  width: 96,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    initialValue: sets[i].repetitions == null
                        ? ""
                        : sets[i].repetitions.toString(),
                    validator: (val) => val!.isEmpty ? "Invalid value" : null,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      hintText: "Repetitions",
                      border: InputBorder.none,
                    ),
                    onChanged: (val) {
                      sets[i].repetitions = int.parse(val);
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
                    initialValue: sets[i].amount == null
                        ? ""
                        : sets[i].amount!.toStringAsFixed(1),
                    validator: (val) => val!.isEmpty ? "Invalid value" : null,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      hintText: "Amount",
                      hintStyle: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                      border: InputBorder.none,
                    ),
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
      width: 96,
      child: MaterialButton(
        padding: EdgeInsets.only(
          top: 4,
          bottom: 4,
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Add set",
              style: TextStyle(
                fontSize: 18,
                fontFamily: "Red Hat Text",
              ),
            ),
          ],
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
    ));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: columnChildren,
    );
  }
}
