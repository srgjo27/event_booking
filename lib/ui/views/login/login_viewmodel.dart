import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LoginViewModel extends BaseViewModel {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;

  bool _rememberMe = false;
  bool get rememberMe => _rememberMe;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void setRememberMe(bool value) {
    _rememberMe = value;
    notifyListeners();
  }

  void signIn() {
    debugPrint('Email: ${emailController.text}');
    debugPrint('Password: ${passwordController.text}');
    debugPrint('Remember Me: $_rememberMe');
  }

  void loginWithGoogle() {
    debugPrint('Login with Google');
  }

  void loginWithFacebook() {
    debugPrint('Login with Facebook');
  }

  void navigateToSignUp() {
    debugPrint('Navigate to Sign Up');
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
