import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:spotme/theme/workout_colors.dart';

class Workout {
  Workout(this.id, this.name, this.userId, {this.color = WorkoutColor.NEUTRAL});
  final String id;
  final String name;
  final String userId;
  WorkoutColor color;

  Workout copyWith({
    required String id,
    required String name,
    required String userId,
    color = WorkoutColor.NEUTRAL,
  }) {
    return Workout(id, name, userId, color: color);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'userId': userId,
      'color': color.name,
    };
  }

  static Workout? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;
    try {
      return Workout(
        map['id'],
        map['name'],
        map['userId'],
        color: map['color'],
      );
    } catch (e) {
      return null;
    }
  }

  String toJson() => json.encode(toMap());

  static Workout? fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Workout(id: $id, name: $name, userId: $userId, color: $color)';
  }

  // We assume that if an exercise has the same name, it is the same exercise
  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Workout && o.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ userId.hashCode ^ color.hashCode;
  }
}

enum WorkoutColor { PRIMARY, RED, YELLOW, BLUE, ORANGE, PURPLE, PINK, NEUTRAL }

extension getMaterialColor on WorkoutColor {
  Color getColor() {
    switch (this) {
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
