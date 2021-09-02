import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:home_workouts/model/exercise_set.dart';
import 'package:home_workouts/theme/layout_values.dart';
import 'package:home_workouts/theme/theme_Data.dart';
import 'package:home_workouts/views/shared/padding.dart';
import 'package:home_workouts/views/shared/whitespace.dart';
import 'package:reorderables/reorderables.dart';
import 'package:uuid/uuid.dart';

const _dismissThreshold = 0.4; // must swipe at least 40% to dismiss

double pixelTraversedThreshold = 0.0;
var _delta = 0.0;
bool _deltaReached = false;

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
    pixelTraversedThreshold =
        MediaQuery.of(context).size.width * _dismissThreshold;
    List<Widget> columnChildren = List.generate(
      sets.length,
      (i) => Listener(
        onPointerUp: (PointerUpEvent event) {
          _delta = 0.0;
          _deltaReached = false;
        },
        onPointerMove: (PointerMoveEvent event) {
          _delta += event.delta.dx.abs();
          if (_delta > pixelTraversedThreshold && !_deltaReached) {
            HapticFeedback.lightImpact();
            _deltaReached = true;
          }
        },
        child: Dismissible(
          key: Key(Uuid().v4()),
          direction: DismissDirection.endToStart,
          dragStartBehavior: DragStartBehavior.down,
          onDismissed: (DismissDirection direction) {
            setState(() {
              if (sets.length > 1) {
                sets.removeAt(i);
              }
            });
            HapticFeedback.mediumImpact();
          },
          background: Container(
            padding: containerPadding,
            color: redLightColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.delete_sweep_outlined,
                  color: redDarkColor,
                ),
              ],
            ),
          ),
          child: Container(
            padding: containerPadding,
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: SMALL / 2,
                        ),
                        Text(
                          "Repetitions",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        Row(
                          children: [
                            Container(
                              width: LARGER,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                alignment: Alignment.centerLeft,
                                iconSize: LARGER,
                                splashRadius: LARGE + 2,
                                onPressed: () {
                                  setState(() {
                                    HapticFeedback.selectionClick();
                                    // lower sets repetitions if possible
                                    sets[i].repetitions =
                                        sets[i].repetitions == null ||
                                                sets[i].repetitions! <= 1
                                            ? 1
                                            : sets[i].repetitions! - 1;
                                  });
                                },
                                icon: Icon(Icons.remove_circle_outline),
                              ),
                            ),
                            Container(
                              width: SMALL,
                            ),
                            Container(
                              width: LARGEST,
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                initialValue: sets[i].repetitions == null
                                    ? "1"
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
                                        (sets[i].repetitions ?? 1) + 1;
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
                            decoration: InputDecoration(
                              hintText: "-",
                            ),
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
                  ],
                ),
                Container(
                  height: SMALL,
                ),
                Container(
                  height: SMALL / 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );

    var _addSetsButton = Padding(
      padding: containerPadding,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              TextButton(
                child: Text(
                  "Add set",
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
