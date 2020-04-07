import 'dart:convert';

class Exercise {
  String type;
  int amount;
  String unit;
  DateTime createDate;

  Exercise({
    this.type,
    this.amount,
    this.unit,
    this.createDate,
  });

  Exercise copyWith({
    String type,
    int amount,
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
