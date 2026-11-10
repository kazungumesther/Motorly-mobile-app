
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:vroom/model/auth-exception.dart';
import 'package:vroom/services/auth_api.dart';

class AuthView extends ChangeNotifier {
  late AuthApi _authApi;

  String? errorMessage;
  UserCredential? result;
  bool isLoading = false;

  AuthView({AuthApi? authApi}) {
    _authApi = authApi ?? AuthApi();
  }

  Future<bool> login(String email, String password) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      result = await _authApi.login(email, password);
      return true;
    } on AuthException catch (e) {
      errorMessage = e.message;
      return false;
    } catch (_) {
      errorMessage = 'Something went wrong. Please try again.';
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      result = await _authApi.register(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
      );
      return true;
    } on AuthException catch (e) {
      errorMessage = e.message;
      return false;
    } catch (_) {
      errorMessage = 'Unable to create your account. Please try again.';
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    try {
      await _authApi.logout();
      result = null;
      errorMessage = null;
      notifyListeners();
    } catch (_) {
      errorMessage = 'Unable to log out. Please try again.';
      notifyListeners();
    }
  }
}
