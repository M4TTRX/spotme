import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:home_workouts/model/exercise_model.dart';
import 'package:home_workouts/model/user_model.dart';

class Challenge {
  // The unique identifier to that challenge
  String id;

  String name;
  // The exercise that will have to be done daily
  Exercise exercise;
  // How much you have to do of the challenge every day
  double amountRequiredPerDay;
  // Duration of one cycle of the challenge in days
  double duration;
  // The all the participants in the challenge
  List<User> participants;

  // the day the challenge started
  DateTime startDate;

  // Generated methods
  // ==============================================================================
  Challenge({
    this.id,
    this.name,
    this.exercise,
    this.amountRequiredPerDay,
    this.duration,
    this.participants,
    this.startDate,
  });

  Challenge copyWith({
    String id,
    String name,
    Exercise exercise,
    double amountRequiredPerDay,
    double duration,
    List<User> participants,
    DateTime startDate,
  }) {
    return Challenge(
      id: id ?? this.id,
      name: name ?? this.name,
      exercise: exercise ?? this.exercise,
      amountRequiredPerDay: amountRequiredPerDay ?? this.amountRequiredPerDay,
      duration: duration ?? this.duration,
      participants: participants ?? this.participants,
      startDate: startDate ?? this.startDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'exercise': exercise.toMap(),
      'amountRequiredPerDay': amountRequiredPerDay,
      'duration': duration,
      'participants': List<dynamic>.from(participants.map((x) => x.toMap())),
      'startDate': startDate.millisecondsSinceEpoch,
    };
  }

  static Challenge fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Challenge(
      id: map['id'],
      name: map['name'],
      exercise: Exercise.fromMap(map['exercise']),
      amountRequiredPerDay: map['amountRequiredPerDay'],
      duration: map['duration'],
      participants:
          List<User>.from(map['participants']?.map((x) => User.fromMap(x))),
      startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate']),
    );
  }

  String toJson() => json.encode(toMap());

  static Challenge fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Challenge(id: $id, name: $name, exercise: $exercise, amountRequiredPerDay: $amountRequiredPerDay, duration: $duration, participants: $participants, startDate: $startDate)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Challenge &&
        o.id == id &&
        o.name == name &&
        o.exercise == exercise &&
        o.amountRequiredPerDay == amountRequiredPerDay &&
        o.duration == duration &&
        listEquals(o.participants, participants) &&
        o.startDate == startDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        exercise.hashCode ^
        amountRequiredPerDay.hashCode ^
        duration.hashCode ^
        participants.hashCode ^
        startDate.hashCode;
  }

  String getChallengeType() => this.exercise.type;
}
