import 'dart:convert';

import 'package:home_workouts/model/user_model.dart';

class DatabaseExercise {
  // type describes the type of the exercise
  String type;
  // amount defines the quantity of the exercise, can be weight, distance, reps ect...
  double amount;
  // unit defines what was done, the amount is meaningless if there is no unit
  String unit;
  // create date is a timestamp at which the exercise was done
  DateTime createDate;
  // userID is the id person who performed the exercise
  String userID;

  // Generated methods
  // ==============================================================================
  DatabaseExercise({
    this.type,
    this.amount,
    this.unit,
    this.createDate,
  });

  DatabaseExercise copyWith({
    String type,
    double amount,
    String unit,
    DateTime createDate,
  }) {
    return DatabaseExercise(
      type: type ?? this.type,
      amount: amount ?? this.amount,
      unit: unit ?? this.unit,
      createDate: createDate ?? this.createDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'amount': amount,
      'unit': unit,
      'createDate': createDate.millisecondsSinceEpoch,
    };
  }

  static DatabaseExercise fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return DatabaseExercise(
      type: map['type'],
      amount: map['amount'],
      unit: map['unit'],
      createDate: DateTime.fromMillisecondsSinceEpoch(map['createDate']),
    );
  }

  String toJson() => json.encode(toMap());

  static DatabaseExercise fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() {
    return 'DatabaseExercise(type: $type, amount: $amount, unit: $unit, createDate: $createDate)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DatabaseExercise &&
        o.type == type &&
        o.amount == amount &&
        o.unit == unit &&
        o.createDate == createDate;
  }

  @override
  int get hashCode {
    return type.hashCode ^
        amount.hashCode ^
        unit.hashCode ^
        createDate.hashCode;
  }
}
