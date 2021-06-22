import 'dart:convert';

class ExerciseSet {
  // Amount describes the amount performed during the set
  double? amount;
  // Repetitions describes how many times the amont was done during the set
  int? repetitions;
  ExerciseSet({
    this.amount,
    this.repetitions,
  });

  ExerciseSet copyWith({
    double? amount,
    int? repetitions,
  }) {
    return ExerciseSet(
      amount: amount ?? this.amount,
      repetitions: repetitions ?? this.repetitions,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'repetitions': repetitions,
    };
  }

  static ExerciseSet? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;

    return ExerciseSet(
      amount: map['amount'],
      repetitions: map['repetitions'],
    );
  }

  String toJson() => json.encode(toMap());

  static ExerciseSet? fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() =>
      'ExerciseSet(amount: $amount, repetitions: $repetitions)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ExerciseSet &&
        o.amount == amount &&
        o.repetitions == repetitions;
  }

  @override
  int get hashCode => amount.hashCode ^ repetitions.hashCode;
}
