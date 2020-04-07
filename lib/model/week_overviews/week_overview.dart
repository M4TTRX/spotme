import 'dart:convert';

import 'package:home_workouts/model/week_overviews/week_exercise.dart';

class WeekOverview {
  List<WeekExercise> exercises;
  DateTime startOfWeek;
  DateTime endOfWeek;
  WeekOverview({
    this.exercises,
    this.startOfWeek,
    this.endOfWeek,
  });

  WeekOverview copyWith({
    List<WeekExercise> exercises,
    DateTime startOfWeek,
    DateTime endOfWeek,
  }) {
    return WeekOverview(
      exercises: exercises ?? this.exercises,
      startOfWeek: startOfWeek ?? this.startOfWeek,
      endOfWeek: endOfWeek ?? this.endOfWeek,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'exercises': List<dynamic>.from(exercises.map((x) => x.toMap())),
      'startOfWeek': startOfWeek.millisecondsSinceEpoch,
      'endOfWeek': endOfWeek.millisecondsSinceEpoch,
    };
  }

  static WeekOverview fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return WeekOverview(
      exercises: List<WeekExercise>.from(
          map['exercises']?.map((x) => WeekExercise.fromMap(x))),
      startOfWeek: DateTime.fromMillisecondsSinceEpoch(map['startOfWeek']),
      endOfWeek: DateTime.fromMillisecondsSinceEpoch(map['endOfWeek']),
    );
  }

  String toJson() => json.encode(toMap());

  static WeekOverview fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() =>
      'WeekOverview(exercises: $exercises, startOfWeek: $startOfWeek, endOfWeek: $endOfWeek)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is WeekOverview &&
        o.exercises == exercises &&
        o.startOfWeek == startOfWeek &&
        o.endOfWeek == endOfWeek;
  }

  @override
  int get hashCode =>
      exercises.hashCode ^ startOfWeek.hashCode ^ endOfWeek.hashCode;
}
