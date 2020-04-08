import 'package:cloud_firestore/cloud_firestore.dart';

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
  final CollectionReference challengesCollection =
      Firestore.instance.collection(_CHALLENGES_COLLECTION);
}
