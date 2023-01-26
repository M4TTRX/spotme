import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:spotme/model/exercise_set.dart';
import 'package:spotme/theme/layout_values.dart';
import 'package:spotme/theme/theme_Data.dart';
import 'package:spotme/views/shared/padding.dart';
import 'package:spotme/views/shared/whitespace.dart';
import 'package:reorderables/reorderables.dart';
import 'package:uuid/uuid.dart';
import 'package:spring_button/spring_button.dart';

import '../shared/buttons/buttonStyles.dart';

const _dismissThreshold = 0.4; // must swipe at least 40% to dismiss

double pixelTraversedThreshold = 0.0;
var _delta = 0.0;
bool _deltaReached = false;

class AddSetsView extends StatefulWidget {
  final List<ExerciseSet>? sets;
  final Key addSetsViewKey;
  AddSetsView(this.sets, this.addSetsViewKey) : super(key: addSetsViewKey);
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
            color: Theme.of(context).colorScheme.background,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(LayoutValues.MEDIUM),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.errorContainer,
                      shape: BoxShape.circle),
                  child: Icon(
                    Icons.delete_sweep_outlined,
                    color: Theme.of(context).colorScheme.onErrorContainer,
                  ),
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
                          height: LayoutValues.SMALL / 2,
                        ),
                        Text(
                          "Repetitions",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        Row(
                          children: [
                            Container(
                              width: LayoutValues.LARGER,
                              child: SpringButton(
                                SpringButtonType.WithOpacity,
                                Icon(
                                  Icons.remove_circle_outline,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                  size: LayoutValues.LARGER,
                                ),
                                onTapUp: (_) {
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
                                onLongPress: () {
                                  setState(() {
                                    HapticFeedback.selectionClick();
                                    // lower sets repetitions if possible
                                    sets[i].repetitions = 1;
                                  });
                                },
                              ),
                            ),
                            Container(
                              width: LayoutValues.SMALL,
                            ),
                            Container(
                              width: LayoutValues.LARGEST,
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
                              child: SpringButton(
                                SpringButtonType.WithOpacity,
                                Icon(
                                  Icons.add_circle_outline,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                  size: LayoutValues.LARGER,
                                ),
                                onTapUp: (_) {
                                  HapticFeedback.selectionClick();
                                  setState(() {
                                    sets[i].repetitions =
                                        (sets[i].repetitions ?? 1) + 1;
                                  });
                                },
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
                  height: LayoutValues.SMALL,
                ),
                Container(
                  height: LayoutValues.SMALL / 2,
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
                style: ButtonStyles.greyButton(context),
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
