import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_workouts/model/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user from firebase user
  User _userFromFirebaseUser(FirebaseUser firebaseUser) {
    if (firebaseUser == null) {
      return null;
    }
    return User(
      id: firebaseUser.uid,
      email: firebaseUser.email,
      username: firebaseUser.displayName ?? "Rando",
    );
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  Future _handleError(Error e) {
    print(e.toString());
    return null;
  }

  // sign in anon
  Future signInAnon() async {
    try {
      AuthResult authResult = await _auth.signInAnonymously();
      FirebaseUser user = authResult.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      return _handleError(e);
    }
  }

  // signIn signs in the user with an email and a password
  Future signIn(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseUser firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      return null;
    }
  }

  // registerWithEmailAndPassword registers a new account with the email and password in firebase
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseUser firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      return _handleError(e);
    }
  }

  // signOut signs out the user from their account
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return _handleError(e);
    }
  }
}
