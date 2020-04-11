import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:home_workouts/model/database/exercise_db_model.dart';
import 'package:home_workouts/model/user_model.dart';

class FireStoreDatabaseService {
  final String userId;
  FireStoreDatabaseService({
    this.userId,
  });
  // Firestore collection constant names
  static const String _USER_COLLECTION = "users";
  static const String _EXERCISES_COLLECTION = "exercises";
  static const String _CHALLENGES_COLLECTION = "challenges";

  // Users Firestore collection
  final CollectionReference usersCollection =
      Firestore.instance.collection(_USER_COLLECTION);

  Future upsertUser(User user) async {
    return await usersCollection.document(user.id).setData(user.toMap());
  }

  User _getUserFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return User.fromMap(doc.data);
    }).toList()[0];
  }

  Stream<User> get users {
    return usersCollection
        .where("id", isEqualTo: this.userId)
        .snapshots()
        .map(_getUserFromSnapshot);
  }

  final CollectionReference exercisesCollection =
      Firestore.instance.collection(_EXERCISES_COLLECTION);

  Future upsertExercise(DatabaseExercise exercise) async {
    return await exercisesCollection
        .document(exercise.id)
        .setData(exercise.toMap());
  }

  final CollectionReference challengesCollection =
      Firestore.instance.collection(_CHALLENGES_COLLECTION);

  FireStoreDatabaseService copyWith({
    String userId,
  }) {
    return FireStoreDatabaseService(
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
    };
  }

  static FireStoreDatabaseService fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return FireStoreDatabaseService(
      userId: map['userId'],
    );
  }

  String toJson() => json.encode(toMap());

  static FireStoreDatabaseService fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() => 'FireStoreDatabaseService(userId: $userId)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is FireStoreDatabaseService && o.userId == userId;
  }

  @override
  int get hashCode => userId.hashCode;
}
