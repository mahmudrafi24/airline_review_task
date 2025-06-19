import 'package:airline_reveiw/screen/auth_screen/signup_screen/controller/signup_screen_controller.dart';
import 'package:airline_reveiw/utils/app_colors/app_colors.dart';
import 'package:airline_reveiw/utils/app_images/app_images.dart';
import 'package:airline_reveiw/utils/app_string/app_string.dart';
import 'package:airline_reveiw/widget/app_button/app_button.dart';
import 'package:airline_reveiw/widget/app_size/app_gap.dart';
import 'package:airline_reveiw/widget/app_size/app_size.dart';
import 'package:airline_reveiw/widget/app_text/app_text.dart';
import 'package:airline_reveiw/widget/app_text_filed/app_text_filed.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSize.width(value: 20)),
        child: Form(
          key: controller.signupFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Gap(
                height: AppSize.height(value: 50),
              ),
              Center(
                child: Column(
                  children: [
                    AppText(
                      text: AppString.appName,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: AppColors.buttonColor,
                    ),
                    Image.asset(
                      AppImages.iconImage,
                      height: AppSize.height(value: 200),
                      width: AppSize.width(value: 200),
                    ),
                    AppText(
                      text: AppString.motto,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ),
                    Gap(
                      height: AppSize.height(value: 10),
                    ),
                    AppText(
                      text: AppString.createAccount,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: AppColors.buttonColor,
                    ),
                  ],
                ),
              ),
              Gap(
                height: AppSize.height(value: 30),
              ),
              //! Name Field
              AppText(
                text: AppString.name,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
              Gap(
                height: AppSize.height(value: 10),
              ),
              CustomTextField(
                controller: controller.nameController,
                backgroundColor: AppColors.white,
                keyboardType: TextInputType.name,
                height: 50,
                borderRadius: 12,
                hintText: "Enter your name",
                hintTextColor: AppColors.hintTextColor,
                borderColor: AppColors.borderColor,
                validator: controller.validateName,
              ),
              Gap(
                height: AppSize.height(value: 10),
              ),
              //! Email Field
              AppText(
                text: AppString.email,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
              Gap(
                height: AppSize.height(value: 10),
              ),
              CustomTextField(
                controller: controller.emailController,
                backgroundColor: AppColors.white,
                keyboardType: TextInputType.emailAddress,
                height: 50,
                borderRadius: 12,
                hintText: AppString.enterYourEmail,
                hintTextColor: AppColors.hintTextColor,
                borderColor: AppColors.borderColor,
                validator: controller.validateEmail,
              ),
              Gap(
                height: AppSize.height(value: 10),
              ),
              //! Password Field
              AppText(
                text: AppString.password,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
              Gap(
                height: AppSize.height(value: 10),
              ),
              Obx(() => CustomTextField(
                    controller: controller.passwordController,
                    backgroundColor: AppColors.white,
                    keyboardType: TextInputType.visiblePassword,
                    height: 50,
                    borderRadius: 12,
                    hintText: AppString.enterYourPassword,
                    hintTextColor: AppColors.hintTextColor,
                    borderColor: AppColors.borderColor,
                    isPassword: controller.hidePassword.value,
                    validator: controller.validatePassword,
                  )),
              Gap(
                height: AppSize.height(value: 5),
              ),
              // Password strength indicator
              Obx(() {
                final password = controller
                    .currentPassword.value; // Use reactive variable instead
                if (password.isEmpty) return const SizedBox.shrink();

                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSize.width(value: 12),
                    vertical: AppSize.height(value: 4),
                  ),
                  decoration: BoxDecoration(
                    color: controller
                        .getPasswordStrengthColor(password)
                        .withAlpha(25),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: AppText(
                    text:
                        "Password strength: ${controller.getPasswordStrength(password)}",
                    fontSize: 12,
                    color: controller.getPasswordStrengthColor(password),
                    fontWeight: FontWeight.w500,
                  ),
                );
              }),
              Gap(
                height: AppSize.height(value: 10),
              ),
              //! Confirm Password Field
              AppText(
                text: AppString.confirmPassword,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
              Gap(
                height: AppSize.height(value: 10),
              ),
              Obx(() => CustomTextField(
                    controller: controller.confirmPasswordController,
                    backgroundColor: AppColors.white,
                    keyboardType: TextInputType.visiblePassword,
                    height: 50,
                    borderRadius: 12,
                    hintText: AppString.confirmPassword,
                    hintTextColor: AppColors.hintTextColor,
                    borderColor: AppColors.borderColor,
                    isPassword: controller.hideConfirmPassword.value,
                    validator: controller.validateConfirmPassword,
                  )),
              Gap(
                height: AppSize.height(value: 15),
              ),
              // Terms and conditions checkbox
              Obx(() => Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: controller.acceptTerms.value,
                        onChanged: (value) => controller.toggleAcceptTerms(),
                        activeColor: AppColors.buttonColor,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: controller.toggleAcceptTerms,
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: AppSize.height(value: 12)),
                            child: RichText(
                              text: TextSpan(
                                text: "I agree to the ",
                                style: TextStyle(
                                  color: AppColors.textColor,
                                  fontSize: 14,
                                ),
                                children: [
                                  TextSpan(
                                    text: "Terms and Conditions",
                                    style: TextStyle(
                                      color: AppColors.buttonColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " and ",
                                    style: TextStyle(
                                      color: AppColors.textColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Privacy Policy",
                                    style: TextStyle(
                                      color: AppColors.buttonColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              Gap(
                height: AppSize.height(value: 20),
              ),
              //! Signup Button
              Obx(() => AppButton(
                    title: AppString.signUp,
                    width: double.infinity,
                    height: 50,
                    backgroundColor: AppColors.buttonColor,
                    titleColor: AppColors.white,
                    borderradius: 12,
                    isLoading: controller.isLoading.value,
                    onTap: controller.createAccount,
                  )),
              Gap(
                height: AppSize.height(value: 20),
              ),
              Center(
                child: InkWell(
                  onTap: controller.goToLogin,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                          text: "Login",
                          style: TextStyle(
                            color: AppColors.buttonColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Gap(
                height: AppSize.height(value: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
