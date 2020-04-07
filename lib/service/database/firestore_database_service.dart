import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreDatabaseService {
  final CollectionReference usersCollection =
      Firestore.instance.collection("users");
}
