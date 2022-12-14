import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:spotme/theme/workout_colors.dart';

class Workout {
  Workout(this.id, this.name, this.userID, {this.color = WorkoutColor.NEUTRAL});
  final String id;
  final String name;
  final String userID;
  WorkoutColor color;

  Workout copyWith({
    required String id,
    required String name,
    required String userID,
    color = WorkoutColor.NEUTRAL,
  }) {
    return Workout(id, name, userID, color: color);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'userID': userID,
      'color': color.name,
    };
  }

  static Workout? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;
    try {
      return Workout(
        map['id'],
        map['name'],
        map['userID'],
        color: _getWorkoutColorFromMap(map),
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
    return 'Workout(id: $id, name: $name, userID: $userID, color: $color)';
  }

  // We assume that if an exercise has the same name, it is the same exercise
  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Workout && o.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ userID.hashCode ^ color.hashCode;
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
