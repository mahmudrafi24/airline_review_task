import 'package:airline_reveiw/screen/splash_screen/controller/splash_screen_controller.dart';
import 'package:airline_reveiw/utils/app_colors/app_colors.dart';
import 'package:airline_reveiw/utils/app_images/app_images.dart';
import 'package:airline_reveiw/utils/app_string/app_string.dart';
import 'package:airline_reveiw/widget/app_size/app_size.dart';
import 'package:airline_reveiw/widget/app_text/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashScreenController());
    Size size = MediaQuery.of(context).size;
    AppSize.size = size;

    return Scaffold(
        backgroundColor: AppColors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.iconImage,
                height: AppSize.height(value: 200),
                width: AppSize.width(value: 200),
              ),
              AppText(
                text: AppString.appName,
                fontSize: 60,
                fontWeight: FontWeight.w600,
                color: AppColors.buttonColor,
              ),
            ],
          ),
        ));
  }
}
