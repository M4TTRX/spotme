import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:home_workouts/model/exercise_set.dart';
import 'package:home_workouts/views/shared/padding.dart';
import 'package:home_workouts/views/shared/whitespace.dart';
import 'package:reorderables/reorderables.dart';
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

  @override
  Widget build(
    BuildContext context,
  ) {
    List<Widget> columnChildren = List.generate(
        sets.length,
        (i) => Padding(
              padding: containerPadding,
              child: Column(
                children: [
                  Container(
                    height: 8,
                  ),
                  Row(
                    key: Key(Uuid().v4()),
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Repetitions",
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 32,
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  alignment: Alignment.centerLeft,
                                  iconSize: 32,
                                  splashRadius: 36,
                                  onPressed: () {
                                    setState(() {
                                      HapticFeedback.selectionClick();
                                      // lower sets repetitions if possible
                                      sets[i].repetitions =
                                          sets[i].repetitions == null ||
                                                  sets[i].repetitions == 0
                                              ? 0
                                              : sets[i].repetitions! - 1;
                                    });
                                  },
                                  icon: Icon(Icons.remove_circle_outline),
                                ),
                              ),
                              Container(
                                width: 8,
                              ),
                              Container(
                                width: 64,
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  initialValue: sets[i].repetitions == null
                                      ? "0"
                                      : sets[i].repetitions.toString(),
                                  validator: (val) =>
                                      val!.isEmpty ? "Invalid value" : null,
                                  style: Theme.of(context).textTheme.headline4,
                                  onChanged: (val) {
                                    sets[i].repetitions = int.parse(val);
                                  },
                                ),
                              ),
                              Container(
                                width: 8,
                              ),
                              Container(
                                width: 32,
                                child: IconButton(
                                  onPressed: () {
                                    HapticFeedback.selectionClick();
                                    setState(() {
                                      sets[i].repetitions =
                                          (sets[i].repetitions ?? 0) + 1;
                                    });
                                  },
                                  padding: EdgeInsets.zero,
                                  iconSize: 32,
                                  splashRadius: 36,
                                  icon: Icon(Icons.add_circle_outline),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      WhiteSpace(),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Weight",
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          Container(
                            width: 120,
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              initialValue: sets[i].amount == null
                                  ? ""
                                  : sets[i].amount!.toStringAsFixed(1),
                              validator: (val) =>
                                  val!.isEmpty ? "Invalid value" : null,
                              style: Theme.of(context).textTheme.headline4,
                              onChanged: (val) {
                                sets[i].amount = double.parse(val);
                              },
                            ),
                          ),
                        ],
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
                                  HapticFeedback.selectionClick();
                                  sets.removeAt(i);
                                });
                              },
                            )
                    ],
                  ),
                  Container(
                    height: 8,
                  ),
                  Divider()
                ],
              ),
            ));

    var _addSetsButton = Padding(
      padding: containerPadding,
      child: Column(
        children: [
          Container(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              TextButton(
                child: Text(
                  "Add set",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Red Hat Text",
                  ),
                ),
                onPressed: () {
                  setState(() {
                    HapticFeedback.lightImpact();
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
        ],
      ),
    );

    return SliverToBoxAdapter(
      child: ShrinkWrappingViewport(offset: ViewportOffset.zero(), slivers: [
        ReorderableSliverList(
          delegate: ReorderableSliverChildListDelegate(columnChildren),
          onReorder: (int oldIndex, int newIndex) {
            setState(() {
              HapticFeedback.lightImpact();

              ExerciseSet row = sets.removeAt(oldIndex);
              sets.insert(newIndex, row);
            });
          },
        ),
        SliverList(
          delegate: SliverChildListDelegate([_addSetsButton]),
        )
      ]),
    );
  }
}
