import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:home_workouts/model/challenges/challenge.dart';

import '../exercise_model.dart';

class ChallengeProgress {
  // The challenge being tracked
  Challenge challenge;
  // the exercises accomplished towards that challenge
  List<Exercise> exercises;

  // missingExercise is the exercise the user would have to do in order to be caught up
  Exercise missingExercise;
  ChallengeProgress({
    this.challenge,
    this.exercises,
    this.missingExercise,
  });

  ChallengeProgress copyWith({
    Challenge challenge,
    List<Exercise> exercises,
    Exercise missingExercise,
  }) {
    return ChallengeProgress(
      challenge: challenge ?? this.challenge,
      exercises: exercises ?? this.exercises,
      missingExercise: missingExercise ?? this.missingExercise,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'challenge': challenge.toMap(),
      'exercises': List<dynamic>.from(exercises.map((x) => x.toMap())),
      'missingExercise': missingExercise.toMap(),
    };
  }

  static ChallengeProgress fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ChallengeProgress(
      challenge: Challenge.fromMap(map['challenge']),
      exercises: List<Exercise>.from(
          map['exercises']?.map((x) => Exercise.fromMap(x))),
      missingExercise: Exercise.fromMap(map['missingExercise']),
    );
  }

  String toJson() => json.encode(toMap());

  static ChallengeProgress fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() =>
      'ChallengeProgress(challenge: $challenge, exercises: $exercises, missingExercise: $missingExercise)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ChallengeProgress &&
        o.challenge == challenge &&
        listEquals(o.exercises, exercises) &&
        o.missingExercise == missingExercise;
  }

  @override
  int get hashCode =>
      challenge.hashCode ^ exercises.hashCode ^ missingExercise.hashCode;

  String getChallengeType() => this.challenge.getChallengeType();

  int getCompleted() {
    return 2;
  }

  int getNeeded() {
    return 10;
  }
}
