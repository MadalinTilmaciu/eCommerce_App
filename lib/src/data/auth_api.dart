import 'package:firebase_auth/firebase_auth.dart';

import '../models/index.dart';

class AuthApi {
  AuthApi(this._auth);

  final FirebaseAuth _auth;

  Future<AppUser?> checkUser() async {
    final User? user = _auth.currentUser;

    if (user == null) {
      return null;
    }

    return AppUser(
      uid: user.uid,
      email: user.email!,
      displayName: user.displayName ?? user.email!.split('@').first,
      profileUrl: user.photoURL,
    );
  }

  Future<AppUser> createUser({required String email, required String password}) async {
    final UserCredential credentials = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    final User user = credentials.user!;

    return AppUser(
      uid: user.uid,
      email: email,
      displayName: user.displayName ?? email.split('@').first,
      profileUrl: user.photoURL,
    );
  }

  Future<AppUser> loginUser({required String email, required String password}) async {
    final UserCredential credentials = await _auth.signInWithEmailAndPassword(email: email, password: password);
    final User user = credentials.user!;

    return AppUser(
      uid: user.uid,
      email: email,
      displayName: user.displayName ?? email.split('@').first,
      profileUrl: user.photoURL,
    );
  }

  Future<void> logoutUser() async {
    _auth.signOut();
  }
}
