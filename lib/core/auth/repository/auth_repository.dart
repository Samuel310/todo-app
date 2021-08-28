import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  late FirebaseAuth _auth;

  AuthRepository() {
    _auth = FirebaseAuth.instance;
  }

  Future<void> login({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e.toString());
      if (e is FirebaseAuthException) {
        return Future.error(e.message.toString());
      }
      return Future.error('Unable to login at this time');
    }
  }

  Future<void> register({required String email, required String password, required String name}) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await updateUserName(name: name);
    } catch (e) {
      print(e.toString());
      if (e is FirebaseAuthException) {
        return Future.error(e.message.toString());
      }
      return Future.error('Unable to register at this time');
    }
  }

  Future<void> updateUserName({required String name}) async {
    try {
      await _auth.currentUser!.updateDisplayName(name);
      _auth.currentUser!.reload();
    } catch (e) {
      print(e.toString());
      return Future.error('Unable to update at this time');
    }
  }

  Future<void> forgotPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
      if (e is FirebaseAuthException) {
        return Future.error(e.message.toString());
      }
      return Future.error('Unable to recover at this time');
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
