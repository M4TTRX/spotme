import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../exercise_model.dart';
import '../user_model.dart';
import 'challenge_model.dart';

class UserChallengeProgress {
  // user is the user who's challenge progress is tracked
  User user;
  // The challenge being tracked
  Challenge challenge;
  // the exercises accomplished towards that challenge
  List<Exercise> exercises;
  // missingExercise is the exercise the user would have to do in order to be caught up
  Exercise missingExercise;

  Exercise getAddProgressExercise() {
    Exercise exercise = this.challenge.exercise;
    exercise.amount = this.getNeeded() - this.getCompleted();
    return exercise;
  }

  // Generated methods
  // ==============================================================================
  UserChallengeProgress({
    this.challenge,
    this.exercises,
    this.missingExercise,
  });

  UserChallengeProgress copyWith({
    Challenge challenge,
    List<Exercise> exercises,
    Exercise missingExercise,
  }) {
    return UserChallengeProgress(
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

  static UserChallengeProgress fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return UserChallengeProgress(
      challenge: Challenge.fromMap(map['challenge']),
      exercises: List<Exercise>.from(
          map['exercises']?.map((x) => Exercise.fromMap(x))),
      missingExercise: Exercise.fromMap(map['missingExercise']),
    );
  }

  String toJson() => json.encode(toMap());

  static UserChallengeProgress fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() =>
      'UserChallengeProgress(challenge: $challenge, exercises: $exercises, missingExercise: $missingExercise)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is UserChallengeProgress &&
        o.challenge == challenge &&
        listEquals(o.exercises, exercises) &&
        o.missingExercise == missingExercise;
  }

  @override
  int get hashCode =>
      challenge.hashCode ^ exercises.hashCode ^ missingExercise.hashCode;

  String getChallengeType() => this.challenge.getChallengeType();

  double getCompleted() {
    return 2;
  }

  double getNeeded() {
    return 10;
  }
}
