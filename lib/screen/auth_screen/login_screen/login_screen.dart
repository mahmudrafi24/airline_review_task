import 'package:airline_reveiw/screen/auth_screen/login_screen/controller/login_screen_controller.dart';
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

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppSize.width(value: 20),
        ),
        child: Form(
          key: controller.loginFormKey,
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
                      text: AppString.loginToYourAccount,
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
                height: AppSize.height(value: 05),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    text: "Enter Minimum 8 Character",
                    fontSize: 12,
                    color: AppColors.hintTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                  InkWell(
                    onTap: controller.goToForgotPassword,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: AppText(
                      text: AppString.forgotPassword,
                      fontSize: 12,
                      color: AppColors.textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Gap(
                height: AppSize.height(value: 20),
              ),
              Obx(() => AppButton(
                title: AppString.login,
                width: double.infinity,
                height: 50,
                backgroundColor: AppColors.buttonColor,
                titleColor: AppColors.white,
                borderradius: 12,
                isLoading: controller.isLoading.value,
                onTap: controller.signIn,
              )),
              Gap(
                height: AppSize.height(value: 20),
              ),
              Center(
                child: InkWell(
                  onTap: controller.goToSignup,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                          text: "Sign Up",
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
            ],
          ),
        ),
      ),
    );
  }
}