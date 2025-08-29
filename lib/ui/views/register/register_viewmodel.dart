import 'package:event_booking/app/app.locator.dart';
import 'package:event_booking/app/app.router.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RegisterViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;

  bool _isConfirmPasswordVisible = false;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    notifyListeners();
  }

  void signUp() {
    debugPrint('Full Name: ${fullNameController.text}');
    debugPrint('Email: ${emailController.text}');
    debugPrint('Password: ${passwordController.text}');
    debugPrint('Confirm Password: ${confirmPasswordController.text}');
  }

  void loginWithGoogle() {
    debugPrint('Login with Google');
  }

  void loginWithFacebook() {
    debugPrint('Login with Facebook');
  }

  void navigateToSignIn() {
    debugPrint('Navigate to Sign In');
    _navigationService.navigateToLoginView();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
