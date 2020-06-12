import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:home_workouts/model/user_model.dart';

import 'exercise_set.dart';

class Exercise {
  String id;
  // type describes the type of the exercise
  String type;
  // sets contains what the user did in that exercise
  List<ExerciseSet> sets;
  // unit defines what was done, the amount is meaningless if there is no unit
  String unit;
  // create date is a timestamp at which the exercise was done
  DateTime createDate;
  // user is the person who performed the exercise
  User user;
  // notes represents the optional notes a user may put on their exercise
  String notes;

  // Custom methods
  // ==============================================================================
  String getDisplayAmount() {
    if (sets == null || sets.length == 0) {
      return "0";
    }
    if (sets.length == 1) {
      return sets.length.toString() + " set";
    }
    return sets.length.toString() + " sets";
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
  });

  Exercise copyWith({
    String id,
    String type,
    List<ExerciseSet> sets,
    String unit,
    DateTime createDate,
    User user,
    String notes,
  }) {
    return Exercise(
      id: id ?? this.id,
      type: type ?? this.type,
      sets: sets ?? this.sets,
      unit: unit ?? this.unit,
      createDate: createDate ?? this.createDate,
      user: user ?? this.user,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'sets': sets?.map((x) => x?.toMap())?.toList(),
      'unit': unit,
      'createDate': createDate?.millisecondsSinceEpoch,
      'user': user?.toMap(),
      'notes': notes,
    };
  }

  static Exercise fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Exercise(
      id: map['id'],
      type: map['type'],
      sets: List<ExerciseSet>.from(
          map['sets']?.map((x) => ExerciseSet.fromMap(x))),
      unit: map['unit'],
      createDate: DateTime.fromMillisecondsSinceEpoch(map['createDate']),
      user: User.fromMap(map['user']),
      notes: map['notes'],
    );
  }

  String toJson() => json.encode(toMap());

  static Exercise fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Exercise(id: $id, type: $type, sets: $sets, unit: $unit, createDate: $createDate, user: $user, notes: $notes)';
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
        notes.hashCode;
  }
}
