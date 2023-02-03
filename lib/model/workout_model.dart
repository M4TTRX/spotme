import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:spotme/theme/workout_colors.dart';

class Workout {
  Workout(this.name, this.userID,
      {this.color = WorkoutColor.NEUTRAL, active = true});
  final String name;
  final String userID;
  WorkoutColor color;
  bool active = true;

  Workout copyWith({
    required String name,
    required String userID,
    color = WorkoutColor.NEUTRAL,
      active = true
  }) {
    return Workout(name, userID, color: color, active: active);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'userID': userID,
      'color': color.name,
      'active': active,
    };
  }

  static Workout? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;
    try {
      return Workout(
        map['name'],
        map['userID'],
        color: _getWorkoutColorFromMap(map),
        active: map['userID'],
      );
    } catch (e) {
      print("Couldn't parse workout from map: $map");
      return null;
    }
  }

  static WorkoutColor _getWorkoutColorFromMap(Map<String, dynamic> map) {
    switch (map['color']) {
      case "PRIMARY":
        return WorkoutColor.PRIMARY;
      case "RED":
        return WorkoutColor.RED;
      case "YELLOW":
        return WorkoutColor.YELLOW;
      case "BLUE":
        return WorkoutColor.BLUE;
      case "ORANGE":
        return WorkoutColor.ORANGE;
      case "PURPLE":
        return WorkoutColor.PURPLE;
      case "PINK":
        return WorkoutColor.PINK;
      default:
        return WorkoutColor.NEUTRAL;
    }
  }

  String toJson() => json.encode(toMap());

  static Workout? fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Workout(name: $name, userID: $userID, color: $color)';
  }

  // We assume that if an exercise has the same name, it is the same exercise
  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Workout && o.getId() == this.getId();
  }

  // the id of a workout is name_userID
  String getId() => this.name + "_" + this.userID;

  @override
  int get hashCode {
    return name.hashCode ^ userID.hashCode;
  }
}

enum WorkoutColor { PRIMARY, RED, YELLOW, BLUE, ORANGE, PURPLE, PINK, NEUTRAL }

extension WorkoutColorHelpers on WorkoutColor {
  static Color getColor(WorkoutColor workoutColor) {
    switch (workoutColor) {
      case WorkoutColor.PRIMARY:
        return primaryWorkoutColor;
      case WorkoutColor.RED:
        return redWorkoutColor;
      case WorkoutColor.YELLOW:
        return yellowWorkoutColor;
      case WorkoutColor.BLUE:
        return blueWorkoutColor;
      case WorkoutColor.ORANGE:
        return orangeWorkoutColor;
      case WorkoutColor.PURPLE:
        return purpleWorkoutColor;
      case WorkoutColor.PINK:
        return pinkWorkoutColor;
      case WorkoutColor.NEUTRAL:
        return neutralWorkoutColor;
      default:
        return neutralWorkoutColor;
    }
  }
}
