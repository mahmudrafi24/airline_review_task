import 'package:airline_reveiw/core/app_route/app_route.dart';
import 'package:airline_reveiw/screen/auth_screen/login_screen/controller/login_screen_controller.dart';
import 'package:airline_reveiw/services/repository/auth_repository/auth_repository.dart';
import 'package:airline_reveiw/widget/app_log/app_log.dart';
import 'package:airline_reveiw/widget/app_snacbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // Text editing controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Form key
  final signupFormKey = GlobalKey<FormState>();

  // Observable variables
  final isLoading = false.obs;
  final hidePassword = true.obs;
  final hideConfirmPassword = true.obs;
  final acceptTerms = false.obs;
  final currentPassword = ''.obs; // Add this reactive variable

  // Repository
  final _authRepository = Get.put(AuthRepository());

  @override
  void onInit() {
    super.onInit();
    // Listen to password changes and update reactive variable
    passwordController.addListener(() {
      currentPassword.value = passwordController.text;
    });
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  /// Toggle password visibility
  void togglePasswordVisibility() {
    hidePassword.value = !hidePassword.value;
  }

  /// Toggle confirm password visibility
  void toggleConfirmPasswordVisibility() {
    hideConfirmPassword.value = !hideConfirmPassword.value;
  }

  /// Toggle terms acceptance
  void toggleAcceptTerms() {
    acceptTerms.value = !acceptTerms.value;
  }

  /// Name validation
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    if (value.length > 50) {
      return 'Name cannot exceed 50 characters';
    }
    return null;
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
    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(value)) {
      return 'Password must contain uppercase, lowercase, and number';
    }
    return null;
  }

  /// Confirm password validation
  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  /// Create account
  Future<void> createAccount() async {
    try {
      // Validate form
      if (!signupFormKey.currentState!.validate()) {
        return;
      }

      // Check if terms are accepted
      if (!acceptTerms.value) {
        AppSnackBar.message('Please accept the terms and conditions');
        
        return;
      }

      // Start loading
      isLoading.value = true;

      // Create user
      final userCredential =
          await _authRepository.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (userCredential != null) {
      // Update display name
      await _authRepository.updateDisplayName(nameController.text.trim());

      // Send email verification
      await _authRepository.sendEmailVerification();

      // Show success message
      AppSnackBar.success('Please check your email to verify your account');
      appLog('Signup successful for ${emailController.text.trim()}');

      // Delete the existing LoginController instance to ensure fresh instance
      //Get.delete<LoginController>();
      
      // Navigate to login screen
      Get.offAllNamed(AppRoutes.loginScreen); // Replace with your login route
    }
  } catch (e) {
    // Show error message
    AppSnackBar.error('Failed to create account: ${e.toString()}');
    appLog('Signup error: $e');
  } finally {
    // Stop loading
    isLoading.value = false;
  }
  }

  //! Clear form fields
  void clearForm() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    acceptTerms.value = false;
    currentPassword.value = ''; // Clear reactive variable too
  }

  /// Navigate to login screen
  void goToLogin() {
  clearForm();
  // Delete the existing LoginController instance to ensure fresh instance
  //Get.delete<LoginController>();
  Get.offNamed(AppRoutes.loginScreen); // Replace with your login route
}

  /// Check password strength
  String getPasswordStrength(String password) {
    if (password.isEmpty) return '';

    int score = 0;

    // Length check
    if (password.length >= 8) score++;
    if (password.length >= 12) score++;

    // Character variety checks
    if (RegExp(r'[a-z]').hasMatch(password)) score++;
    if (RegExp(r'[A-Z]').hasMatch(password)) score++;
    if (RegExp(r'[0-9]').hasMatch(password)) score++;
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) score++;

    switch (score) {
      case 0:
      case 1:
      case 2:
        return 'Weak';
      case 3:
      case 4:
        return 'Medium';
      case 5:
      case 6:
        return 'Strong';
      default:
        return 'Very Strong';
    }
  }

  /// Get password strength color
  Color getPasswordStrengthColor(String password) {
    String strength = getPasswordStrength(password);
    switch (strength) {
      case 'Weak':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      case 'Strong':
        return Colors.green;
      case 'Very Strong':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
