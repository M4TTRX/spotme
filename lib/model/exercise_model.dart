import 'dart:convert';

class Exercise {
  String type;
  int amount;
  DateTime timestamp;

  Exercise({
    this.type,
    this.amount,
    this.timestamp,
  });

  Exercise copyWith({
    String type,
    int amount,
    DateTime timestamp,
  }) {
    return Exercise(
      type: type ?? this.type,
      amount: amount ?? this.amount,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'amount': amount,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }

  static Exercise fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Exercise(
      type: map['type'],
      amount: map['amount'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
    );
  }

  String toJson() => json.encode(toMap());

  static Exercise fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() =>
      'Exercise(type: $type, amount: $amount, timestamp: $timestamp)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Exercise &&
        o.type == type &&
        o.amount == amount &&
        o.timestamp == timestamp;
  }

  @override
  int get hashCode => type.hashCode ^ amount.hashCode ^ timestamp.hashCode;
}
