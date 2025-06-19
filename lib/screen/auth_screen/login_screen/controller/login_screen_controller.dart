import 'package:airline_reveiw/core/app_route/app_route.dart';
import 'package:airline_reveiw/services/repository/auth_repository/auth_repository.dart';
import 'package:airline_reveiw/widget/app_snacbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  // Text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Form key
  final loginFormKey = GlobalKey<FormState>();

  // Observable variables
  final isLoading = false.obs;
  final hidePassword = true.obs;

  // Repository
  final _authRepository = Get.put(AuthRepository());

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  /// Toggle password visibility
  void togglePasswordVisibility() {
    hidePassword.value = !hidePassword.value;
  }

  /// Email validation
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  /// Password validation
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  /// Sign in with email and password
  Future<void> signIn() async {
    try {
      // Validate form
      if (!loginFormKey.currentState!.validate()) {
        return;
      }

      // Start loading
      isLoading.value = true;

      // Sign in
      await _authRepository.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Navigate to home or dashboard
      Get.offAllNamed(AppRoutes.homeScreen); // Replace with your home route
      
      // Show success message
      AppSnackBar.success('Login successful!');
      

    } catch (e) {
      // Show error message
      AppSnackBar.error('Login failed: ${e.toString()}');
    } finally {
      // Stop loading
      isLoading.value = false;
    }
  }

  /// Clear form fields
  void clearForm() {
    emailController.clear();
    passwordController.clear();
  }

  /// Navigate to signup screen
  void goToSignup() {
    clearForm();
    Get.toNamed(AppRoutes.signupScreen); // Replace with your signup route
  }

  /// Navigate to forgot password screen
  void goToForgotPassword() {
    Get.toNamed(AppRoutes.forgotPasswordScreen); // Replace with your forgot password route
  }
}