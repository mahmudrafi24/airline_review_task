import 'package:airline_reveiw/core/app_route/app_route.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  void navigateToOnboardScreen() {
    Future.delayed(Duration(seconds: 3), () {
      Get.offAllNamed(AppRoutes.loginScreen);
    });
  }

  @override
  void onInit() {
    super.onInit();
    navigateToOnboardScreen();
  }
}
