import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotme/model/account_model.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  // create user from firebase user
  Account _accountFromFirebaseUser(User firebaseUser) {
    return Account(
      id: firebaseUser.uid,
      email: firebaseUser.email,
      username: firebaseUser.displayName ?? "Rando",
    );
  }

  // auth change user stream
  Stream<Account> get user async* {
    await for (User? firebaseUser in _auth.authStateChanges()) {
      if (firebaseUser != null) {
        print(await firebaseUser.getIdToken());
        yield _accountFromFirebaseUser(firebaseUser);
      } else
        yield new Account(id: null);
    }
  }

  Future? _handleError(dynamic e) {
    print(e.toString());
    return null;
  }

  // sign in anon
  Future? signInAnon() async {
    try {
      UserCredential authResult = await _auth.signInAnonymously();
      User? user = authResult.user;

      return _accountFromFirebaseUser(user!);
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
      User? firebaseUser = result.user;
      return _accountFromFirebaseUser(firebaseUser!);
    } catch (e) {
      return null;
    }
  }

  // registerWithEmailAndPassword registers a new account with the email and password in firebase
  Future? registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? firebaseUser = result.user;
      return _accountFromFirebaseUser(firebaseUser!);
    } catch (e) {
      return _handleError(e);
    }
  }

  // signOut signs out the user from their account
  Future? signOut() async {
    try {
      var response = await _auth.signOut();
      print("signed off successfully!");
      return response;
    } catch (e) {
      return _handleError(e);
    }
  }
}
