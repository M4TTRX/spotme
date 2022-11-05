import 'package:flutter/material.dart';
import 'package:spotme/model/exercise_set.dart';
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
    var heights = List.generate(sets.length, (index) => _rowHeight);
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
                Padding(
                  padding: const EdgeInsets.only(right: 24),
                  child: Icon(
                    Icons.clear,
                    size: 28,
                    color: Theme.of(context).colorScheme.onError,
                  ),
                ),
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
                      hintText: "Reps",
                      border: InputBorder.none,
                    ),
                    onChanged: (val) {
                      sets[i].repetitions = int.parse(val);
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.clear),
                  color: Theme.of(context).colorScheme.onError,
                  iconSize: 22,
                  onPressed: () async* {
                    setState(() {
                      heights[i] = 0;
                    });
                    await Future.delayed(const Duration(seconds: 1), () {});
                    sets.removeAt(i);
                    setState(() {});
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
            sets.add(ExerciseSet());
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
