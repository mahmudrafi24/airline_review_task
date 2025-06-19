import 'package:airline_reveiw/services/repository/auth_repository/auth_repository.dart';
import 'package:airline_reveiw/widget/app_snacbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  static ForgotPasswordController get instance => Get.find();

  // Text editing controller
  final emailController = TextEditingController();

  // Form key
  final forgotPasswordFormKey = GlobalKey<FormState>();

  // Observable variables
  final isLoading = false.obs;
  final emailSent = false.obs;
  final countdown = 0.obs;

  // Repository
  final _authRepository = Get.put(AuthRepository());

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
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

  /// Send password reset email
  Future<void> sendPasswordResetEmail() async {
    try {
      // Validate form
      if (!forgotPasswordFormKey.currentState!.validate()) {
        return;
      }

      // Start loading
      isLoading.value = true;

      // Send reset email
      await _authRepository.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );

      // Mark email as sent
      emailSent.value = true;

      // Start countdown
      startCountdown();

      // Show success message
      AppSnackBar.success('Password reset link has been sent to ${emailController.text.trim()}');

    } catch (e) {
      // Show error message
      AppSnackBar.error('Failed to send password reset email: ${e.toString()}');
    } finally {
      // Stop loading
      isLoading.value = false;
    }
  }

  /// Resend password reset email
  Future<void> resendPasswordResetEmail() async {
    if (countdown.value > 0) {
      AppSnackBar.message('You can resend after ${countdown.value} seconds');
      return;
    }

    await sendPasswordResetEmail();
  }

  /// Start countdown timer
  void startCountdown() {
    countdown.value = 60; // 60 seconds countdown
    
    // Create a timer that decrements countdown every second
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (countdown.value > 0) {
        countdown.value--;
        return true;
      }
      return false;
    });
  }

  /// Clear form fields
  void clearForm() {
    emailController.clear();
    emailSent.value = false;
    countdown.value = 0;
  }

  /// Navigate back to login
  void goBackToLogin() {
    clearForm();
    Get.back();
  }

  /// Check if email exists (optional feature)
  Future<bool> checkIfEmailExists(String email) async {
    try {
      // This is a workaround since Firebase doesn't provide a direct method
      // to check if email exists without attempting to sign in
      await _authRepository.signInWithEmailAndPassword(
        email: email,
        password: 'dummy_password_to_check_email',
      );
      return true;
    } catch (e) {
      // If we get "wrong-password" error, it means email exists
      if (e.toString().contains('wrong-password') || 
          e.toString().contains('invalid-credential')) {
        return true;
      }
      // If we get "user-not-found", email doesn't exist
      return false;
    }
  }

  /// Get formatted countdown text
  String get countdownText {
    if (countdown.value <= 0) return '';
    
    int minutes = countdown.value ~/ 60;
    int seconds = countdown.value % 60;
    
    if (minutes > 0) {
      return '${minutes}m ${seconds}s';
    } else {
      return '${seconds}s';
    }
  }

  /// Check if resend is available
  bool get canResend => countdown.value <= 0 && emailSent.value;
}