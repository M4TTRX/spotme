import 'dart:convert';

import 'package:home_workouts/model/user_model.dart';

class Exercise {
  String id;
  // type describes the type of the exercise
  String type;
  // amount defines the quantity of the exercise, can be weight, distance, reps ect...
  double amount;
  // unit defines what was done, the amount is meaningless if there is no unit
  String unit;
  // create date is a timestamp at which the exercise was done
  DateTime createDate;
  // user is the person who performed the exercise
  User user;

  // Generated methods
  // ==============================================================================
  Exercise({
    this.type,
    this.amount,
    this.unit,
    this.createDate,
  });

  Exercise copyWith({
    String type,
    double amount,
    String unit,
    DateTime createDate,
  }) {
    return Exercise(
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

  static Exercise fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Exercise(
      type: map['type'],
      amount: map['amount'],
      unit: map['unit'],
      createDate: DateTime.fromMillisecondsSinceEpoch(map['createDate']),
    );
  }

  String toJson() => json.encode(toMap());

  static Exercise fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Exercise(type: $type, amount: $amount, unit: $unit, createDate: $createDate)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Exercise &&
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
