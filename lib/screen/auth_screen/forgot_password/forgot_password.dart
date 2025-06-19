import 'package:airline_reveiw/screen/auth_screen/forgot_password/controller/forgot_screen_controller.dart';
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

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgotPasswordController());

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: controller.goBackToLogin,
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.textColor,
          ),
        ),
        title: AppText(
          text: AppString.forgotPassword,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.textColor,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSize.width(value: 20)),
        child: Form(
          key: controller.forgotPasswordFormKey,
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
                    Obx(() => AppText(
                          text: controller.emailSent.value
                              ? "Check your email"
                              : AppString.enterYourEmailToResetPassword,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        )),
                    Gap(
                      height: AppSize.height(value: 10),
                    ),
                    Obx(
                      () => controller.emailSent.value
                          ? AppText(
                              text:
                                  "We've sent a password reset link to ${controller.emailController.text.trim()}",
                              fontSize: 14,
                              color: AppColors.hintTextColor,
                              textAlign: TextAlign.center,
                              maxLines: 3,
                            )
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
              Gap(
                height: AppSize.height(value: 30),
              ),
              Obx(
                () => !controller.emailSent.value
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text: AppString.email,
                            fontSize: 18,
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
                        ],
                      )
                    : const SizedBox.shrink(),
              ),
              Gap(
                height: AppSize.height(value: 30),
              ),
              Obx(() => AppButton(
                    width: double.infinity,
                    height: 50,
                    title: controller.emailSent.value
                        ? (controller.canResend
                            ? "Resend Link"
                            : "Resend in ${controller.countdownText}")
                        : "Send Reset Link",
                    onTap: controller.emailSent.value
                        ? controller.resendPasswordResetEmail
                        : controller.sendPasswordResetEmail,
                    backgroundColor:
                        controller.emailSent.value && !controller.canResend
                            ? AppColors.hintTextColor
                            : AppColors.buttonColor,
                    titleColor: AppColors.white,
                    isLoading: controller.isLoading.value,
                    borderradius: 12,
                  )),
              Gap(
                height: AppSize.height(value: 20),
              ),
              Obx(
                () => controller.emailSent.value
                    ? Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(AppSize.width(value: 16)),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.blue.shade200),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.email_outlined,
                                  size: 48,
                                  color: Colors.blue.shade600,
                                ),
                                Gap(height: AppSize.height(value: 12)),
                                AppText(
                                  text: "Reset link sent!",
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade800,
                                ),
                                Gap(height: AppSize.height(value: 8)),
                                AppText(
                                  text:
                                      "Please check your email and click the reset link to create a new password.",
                                  fontSize: 14,
                                  color: Colors.blue.shade700,
                                  textAlign: TextAlign.center,
                                  maxLines: 3,
                                ),
                              ],
                            ),
                          ),
                          Gap(height: AppSize.height(value: 20)),
                          AppButton(
                            width: double.infinity,
                            height: 50,
                            title: "Back to Login",
                            onTap: controller.goBackToLogin,
                            backgroundColor: AppColors.white,
                            titleColor: AppColors.buttonColor,
                            borderColor: AppColors.buttonColor,
                            borderradius: 12,
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ),
              Gap(
                height: AppSize.height(value: 40),
              ),
              Center(
                child: InkWell(
                  onTap: controller.goBackToLogin,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: RichText(
                    text: TextSpan(
                      text: "Remember your password? ",
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                          text: "Back to Login",
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
