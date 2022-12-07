import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../exercise_set.dart';
import '../workout_model.dart';

class DatabaseExercise {
  // the unique id to identify that exercise
  String? id;
  // type describes the type of the exercise
  String? type;
  // sets contains what the user did in that exercise
  List<ExerciseSet>? sets;
  // unit defines what was done, the amount is meaningless if there is no unit
  String? unit;
  // create date is a timestamp at which the exercise was done
  DateTime? createDate;
  // userID is the ID of the user who performed the exercise
  String? userID;
  // notes represents the optional notes a user may put on their exercise
  String? notes;
  // workout describes the workout this exercise is part of
  Workout? workout;

  // Generated methods
  // ==============================================================================
  DatabaseExercise({
    this.id,
    this.type,
    this.sets,
    this.unit,
    this.createDate,
    this.userID,
    this.notes,
    this.workout,
  });

  DatabaseExercise copyWith({
    String? id,
    String? type,
    List<ExerciseSet>? sets,
    String? unit,
    DateTime? createDate,
    String? userID,
    String? notes,
    Workout? workout,
  }) {
    return DatabaseExercise(
      id: id ?? this.id,
      type: type ?? this.type,
      sets: sets ?? this.sets,
      unit: unit ?? this.unit,
      createDate: createDate ?? this.createDate,
      userID: userID ?? this.userID,
      notes: notes ?? this.notes,
      workout: workout ?? this.workout,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'sets': sets?.map((x) => x.toMap()).toList(),
      'unit': unit,
      'createDate': createDate?.millisecondsSinceEpoch,
      'userID': userID,
      'notes': notes,
      'workout': workout,
    };
  }

  static DatabaseExercise? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;

    return DatabaseExercise(
      id: map['id'],
      type: map['type'],
      sets: List<ExerciseSet>.from(
          map['sets']?.map((x) => ExerciseSet.fromMap(x))),
      unit: map['unit'],
      createDate: DateTime.fromMillisecondsSinceEpoch(map['createDate']),
      userID: map['userID'],
      notes: map['notes'],
      workout: Workout.fromMap(map['workout']),
    );
  }

  String toJson() => json.encode(toMap());

  static DatabaseExercise? fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() {
    return 'DatabaseExercise(id: $id, type: $type, sets: $sets, unit: $unit, createDate: $createDate, userID: $userID, notes: $notes, workout: $workout)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DatabaseExercise &&
        o.id == id &&
        o.type == type &&
        listEquals(o.sets, sets) &&
        o.unit == unit &&
        o.createDate == createDate &&
        o.userID == userID &&
        o.workout == workout &&
        o.notes == notes;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        type.hashCode ^
        sets.hashCode ^
        unit.hashCode ^
        createDate.hashCode ^
        userID.hashCode ^
        workout.hashCode ^
        notes.hashCode;
  }
}
