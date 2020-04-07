import 'dart:convert';

import '../exercise_model.dart';

class WeekExercise {
  int completed;
  int needed;
  String type;
  List<Exercise> exercises;
  WeekExercise({
    this.completed,
    this.needed,
    this.type,
    this.exercises,
  });

  int getNeededDaily() => (this.needed / 7).round();

  WeekExercise copyWith({
    int completed,
    int needed,
    String type,
    List<Exercise> exercises,
  }) {
    return WeekExercise(
      completed: completed ?? this.completed,
      needed: needed ?? this.needed,
      type: type ?? this.type,
      exercises: exercises ?? this.exercises,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'completed': completed,
      'needed': needed,
      'type': type,
      'exercises': List<dynamic>.from(exercises.map((x) => x.toMap())),
    };
  }

  static WeekExercise fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return WeekExercise(
      completed: map['completed'],
      needed: map['needed'],
      type: map['type'],
      exercises: List<Exercise>.from(
          map['exercises']?.map((x) => Exercise.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  static WeekExercise fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'WeekExercise(completed: $completed, needed: $needed, type: $type, exercises: $exercises)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is WeekExercise &&
        o.completed == completed &&
        o.needed == needed &&
        o.type == type &&
        o.exercises == exercises;
  }

  @override
  int get hashCode {
    return completed.hashCode ^
        needed.hashCode ^
        type.hashCode ^
        exercises.hashCode;
  }
}
