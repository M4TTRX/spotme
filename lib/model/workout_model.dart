import 'dart:convert';

class Workout {
  Workout(this.id, this.name, this.userId);
  final String id;
  final String name;
  final String userId;

  Workout copyWith({
    required String id,
    required String name,
    required String userId,
  }) {
    return Workout(id, name, userId);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'userId': userId,
    };
  }

  static Workout? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;
    try {
      return Workout(
        map['id'],
        map['name'],
        map['userId'],
      );
    } catch (e) {
      return null;
    }
  }

  String toJson() => json.encode(toMap());

  static Workout? fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Workout(id: $id, name: $name, userId: $userId)';
  }

  // We assume that if an exercise has the same name, it is the same exercise
  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Workout && o.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ userId.hashCode;
  }
}

enum WorkoutColor {
  PRIMARY,
  BLACK,
  RED,
  YELLOW,
  BLUE,
  ORANGE,
  PURPLE,
  PINK,
  NEUTRAL
}

extension toString on WorkoutColor {
  String toShortString() {
    return this.toString().split('.').last;
  }
}
