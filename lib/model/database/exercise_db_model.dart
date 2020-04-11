import 'dart:convert';

class DatabaseExercise {
  // the unique id to identify that exercise
  String id;
  // type describes the type of the exercise
  String type;
  // amount defines the quantity of the exercise, can be weight, distance, reps ect...
  double amount;
  // unit defines what was done, the amount is meaningless if there is no unit
  String unit;
  // create date is a timestamp at which the exercise was done
  DateTime createDate;
  // userID is the ID of the user who performed the exercise
  String userID;

  // Generated methods
  // ==============================================================================
  DatabaseExercise({
    this.id,
    this.type,
    this.amount,
    this.unit,
    this.createDate,
    this.userID,
  });

  DatabaseExercise copyWith({
    String id,
    String type,
    double amount,
    String unit,
    DateTime createDate,
    String userID,
  }) {
    return DatabaseExercise(
      id: id ?? this.id,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      unit: unit ?? this.unit,
      createDate: createDate ?? this.createDate,
      userID: userID ?? this.userID,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'amount': amount,
      'unit': unit,
      'createDate': createDate.millisecondsSinceEpoch,
      'userID': userID,
    };
  }

  static DatabaseExercise fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return DatabaseExercise(
      id: map['id'],
      type: map['type'],
      amount: map['amount'],
      unit: map['unit'],
      createDate: DateTime.fromMillisecondsSinceEpoch(map['createDate']),
      userID: map['userID'],
    );
  }

  String toJson() => json.encode(toMap());

  static DatabaseExercise fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() {
    return 'DatabaseExercise(id: $id, type: $type, amount: $amount, unit: $unit, createDate: $createDate, userID: $userID)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DatabaseExercise &&
        o.id == id &&
        o.type == type &&
        o.amount == amount &&
        o.unit == unit &&
        o.createDate == createDate &&
        o.userID == userID;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        type.hashCode ^
        amount.hashCode ^
        unit.hashCode ^
        createDate.hashCode ^
        userID.hashCode;
  }
}
