import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:spotme/model/account_model.dart';
import 'package:spotme/model/database/exercise_db_model.dart';
import 'package:spotme/model/workout_model.dart';

import 'exercise_set.dart';

class Exercise {
  String? id;
  // type describes the type of the exercise
  String? type;
  // sets contains what the user did in that exercise
  List<ExerciseSet>? sets;
  // unit defines what was done, the amount is meaningless if there is no unit
  String? unit;
  // create date is a timestamp at which the exercise was done
  DateTime? createDate;
  // user is the person who performed the exercise
  Account? user;
  // notes represents the optional notes a user may put on their exercise
  String? notes;
  // workout associated to this exercise
  Workout? workout;

  // Custom methods
  // ==============================================================================
  String getDisplayAmount() {
    if (sets == null || sets!.length == 0) {
      return "0";
    }
    if (sets!.length == 1) {
      return sets!.length.toString() + " set";
    }
    return sets!.length.toString() + " sets";
  }

  // Generated methods
  // ==============================================================================
  Exercise({
    this.id,
    this.type,
    this.sets,
    this.unit,
    this.createDate,
    this.user,
    this.notes,
    this.workout,
  });

  Exercise copyWith({
    String? id,
    String? type,
    List<ExerciseSet>? sets,
    String? unit,
    DateTime? createDate,
    Account? user,
    String? notes,
    Workout? workout,
  }) {
    return Exercise(
      id: id ?? this.id,
      type: type ?? this.type,
      sets: sets ?? this.sets,
      unit: unit ?? this.unit,
      createDate: createDate ?? this.createDate,
      user: user ?? this.user,
      notes: notes ?? this.notes,
      workout: workout ?? this.workout,
    );
  }

  static Exercise fromDatabaseExercise(DatabaseExercise databaseExercise,
      {Workout? workout = null}) {
    return Exercise(
      id: databaseExercise.id,
      type: databaseExercise.type,
      sets: databaseExercise.sets,
      unit: databaseExercise.unit,
      createDate: databaseExercise.createDate,
      notes: databaseExercise.notes,
      workout: workout,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'sets': sets?.map((x) => x.toMap()).toList(),
      'unit': unit,
      'createDate': createDate?.millisecondsSinceEpoch,
      'user': user?.toMap(),
      'notes': notes,
      'workout': workout?.toMap(),
    };
  }

  static Exercise? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;

    return Exercise(
      id: map['id'],
      type: map['type'],
      sets: List<ExerciseSet>.from(
          map['sets']?.map((x) => ExerciseSet.fromMap(x))),
      unit: map['unit'],
      createDate: DateTime.fromMillisecondsSinceEpoch(map['createDate']),
      user: Account.fromMap(map['user']),
      notes: map['notes'],
      workout: Workout.fromMap(map['workout']),
    );
  }

  String toJson() => json.encode(toMap());

  static Exercise? fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Exercise(id: $id, type: $type, sets: $sets, unit: $unit, createDate: $createDate, user: $user, notes: $notes, workout: $workout)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Exercise &&
        o.id == id &&
        o.type == type &&
        listEquals(o.sets, sets) &&
        o.unit == unit &&
        o.createDate == createDate &&
        o.user == user &&
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
        user.hashCode ^
        workout.hashCode ^
        notes.hashCode;
  }
}
