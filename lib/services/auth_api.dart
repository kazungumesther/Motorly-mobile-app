
import 'package:firebase_auth/firebase_auth.dart';

import 'package:vroom/model/auth-exception.dart';

class AuthApi {
  final FirebaseAuth _firebaseAuth;

  AuthApi({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<UserCredential> login(String email, String password) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthException(
        'Firebase error: ${e.code} - ${e.message}',
      );
    } catch (e) {
      throw AuthException(
        'Login error: $e',
      );
    }
  }

  Future<UserCredential> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      final credential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      await credential.user?.updateDisplayName(
        '$firstName $lastName'.trim(),
      );

      return credential;
    } on FirebaseAuthException catch (e) {
      throw AuthException(
        'Firebase error: ${e.code} - ${e.message}',
      );
    } catch (e) {
      throw AuthException(
        'Registration error: $e',
      );
    }
  }

  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw AuthException(
        'Firebase error: ${e.code} - ${e.message}',
      );
    } catch (e) {
      throw AuthException(
        'Logout error: $e',
      );
    }
  }
}
