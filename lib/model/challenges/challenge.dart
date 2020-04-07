import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:home_workouts/model/exercise_model.dart';

class Challenge {
  // The unique identifier to that challenge
  String id;

  String name;
  // The exercise that will have to be done daily
  Exercise exercise;
  // How much you have to do of the challenge every day
  int amountRequiredPerDay;
  // Duration of one cycle of the challenge in days
  int duration;
  // The uid of all users participating in this challenge
  List<String> participantIDs;

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
    this.participantIDs,
    this.startDate,
  });

  Challenge copyWith({
    String id,
    String name,
    Exercise exercise,
    int amountRequiredPerDay,
    int duration,
    List<String> participantIDs,
    DateTime startDate,
  }) {
    return Challenge(
      id: id ?? this.id,
      name: name ?? this.name,
      exercise: exercise ?? this.exercise,
      amountRequiredPerDay: amountRequiredPerDay ?? this.amountRequiredPerDay,
      duration: duration ?? this.duration,
      participantIDs: participantIDs ?? this.participantIDs,
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
      'participantIDs': List<dynamic>.from(participantIDs.map((x) => x)),
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
      participantIDs: List<String>.from(map['participantIDs']),
      startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate']),
    );
  }

  String toJson() => json.encode(toMap());

  static Challenge fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Challenge(id: $id, name: $name, exercise: $exercise, amountRequiredPerDay: $amountRequiredPerDay, duration: $duration, participantIDs: $participantIDs, startDate: $startDate)';
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
        listEquals(o.participantIDs, participantIDs) &&
        o.startDate == startDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        exercise.hashCode ^
        amountRequiredPerDay.hashCode ^
        duration.hashCode ^
        participantIDs.hashCode ^
        startDate.hashCode;
  }

  String getChallengeType() => this.exercise.type;
}
