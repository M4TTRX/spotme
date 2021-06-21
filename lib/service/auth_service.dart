import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_workouts/model/account_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user from firebase user
  Account _accountFromFirebaseUser(User firebaseUser) {
    if (firebaseUser == null) {
      return null;
    }
    return Account(
      id: firebaseUser.uid,
      email: firebaseUser.email,
      username: firebaseUser.displayName ?? "Rando",
    );
  }

  // auth change user stream
  Stream<Account> get user {
    _auth.authStateChanges().listen((User user) {
      if (user != null) {
        return _accountFromFirebaseUser(user);
      }
    });
  }

  Future _handleError(Error e) {
    print(e.toString());
    return null;
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential authResult = await _auth.signInAnonymously();
      User user = authResult.user;

      return _accountFromFirebaseUser(user);
    } catch (e) {
      return _handleError(e);
    }
  }

  // signIn signs in the user with an email and a password
  Future signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User firebaseUser = result.user;
      return _accountFromFirebaseUser(firebaseUser);
    } catch (e) {
      return null;
    }
  }

  // registerWithEmailAndPassword registers a new account with the email and password in firebase
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User firebaseUser = result.user;
      return _accountFromFirebaseUser(firebaseUser);
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
