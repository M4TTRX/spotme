import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:home_workouts/model/database/exercise_db_model.dart';
import 'package:home_workouts/model/exercise_model.dart';
import 'package:home_workouts/model/account_model.dart';

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
      FirebaseFirestore.instance.collection(_USER_COLLECTION);

  Future upsertUser(Account user) async {
    return await usersCollection.doc(user.id).set(user.toMap());
  }

  Account _getUserFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((DocumentSnapshot documentSnapshot) {
      return Account.fromMap(documentSnapshot.data());
    }).toList()[0];
  }

  Stream<Account> get users {
    return usersCollection
        .where("id", isEqualTo: this.userId)
        .snapshots()
        .map(_getUserFromSnapshot);
  }

  final CollectionReference exercisesCollection =
      FirebaseFirestore.instance.collection(_EXERCISES_COLLECTION);

  Future upsertExercise(DatabaseExercise exercise) async {
    return await exercisesCollection.doc(exercise.id).set(exercise.toMap());
  }

  List<Exercise> _getExercisesFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((DocumentSnapshot documentSnapshot) {
      return Exercise.fromMap(documentSnapshot.data());
    }).toList();
  }

  Stream<List<Exercise>> get exercises {
    return exercisesCollection
        .where("userID", isEqualTo: this.userId)
        .orderBy("createDate", descending: true)
        .snapshots()
        .map(_getExercisesFromSnapshot);
  }

  final CollectionReference challengesCollection =
      FirebaseFirestore.instance.collection(_CHALLENGES_COLLECTION);

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
