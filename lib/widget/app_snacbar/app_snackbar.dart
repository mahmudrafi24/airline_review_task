import 'package:airline_reveiw/utils/app_colors/app_colors.dart';
import 'package:airline_reveiw/widget/app_size/app_size.dart';
import 'package:airline_reveiw/widget/app_text/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSnackBar {
  static error(String parameterValue, {SnackPosition? snackPosition}) {
    Get.showSnackbar(
      GetSnackBar(
        isDismissible: true,
        snackPosition: snackPosition ?? SnackPosition.TOP,
        backgroundColor: AppColors.error.withValues(alpha: 0.9),
        animationDuration: const Duration(seconds: 2),
        duration: const Duration(seconds: 5),
        messageText: AppText(text: parameterValue, color: AppColors.white),
        borderRadius: AppSize.width(value: 5.0),
        padding: EdgeInsets.all(AppSize.width(value: 10.0)),
        margin: EdgeInsets.symmetric(horizontal: AppSize.width(value: 20.0), vertical: AppSize.width(value: 20)),
      ),
    );
  }

  static success(String parameterValue, {SnackPosition? snackPosition, Duration? duration}) {
    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: AppColors.greeen,
        animationDuration: const Duration(seconds: 2),
        duration: duration ?? const Duration(seconds: 3),
        snackPosition: snackPosition ?? SnackPosition.TOP,
        messageText: AppText(text: parameterValue, color: AppColors.white, fontWeight: FontWeight.w500),
        borderRadius: AppSize.width(value: 5.0),
        padding: EdgeInsets.all(AppSize.width(value: 10.0)),
        margin: EdgeInsets.symmetric(horizontal: AppSize.width(value: 20.0), vertical: AppSize.width(value: 20)),
      ),
    );
  }

  static message(String parameterValue, {Color? backgroundColor, Color? color, SnackPosition? snackPosition}) {
    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: backgroundColor ?? AppColors.message,
        animationDuration: const Duration(seconds: 2),
        duration: const Duration(seconds: 3),
        snackPosition: snackPosition ?? SnackPosition.TOP,
        messageText: AppText(text: parameterValue, color: color ?? AppColors.white, fontSize: 16, fontWeight: FontWeight.w400),
        borderRadius: AppSize.width(value: 5.0),
        padding: EdgeInsets.all(AppSize.width(value: 10.0)),
        margin: EdgeInsets.symmetric(horizontal: AppSize.width(value: 20.0), vertical: AppSize.width(value: 20)),
      ),
    );
  }
}