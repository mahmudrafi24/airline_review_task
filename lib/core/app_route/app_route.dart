import 'package:airline_reveiw/core/Internet%20middleware/internet_middleware_check.dart';
import 'package:airline_reveiw/screen/auth_screen/login_screen/login_screen.dart';
import 'package:airline_reveiw/screen/auth_screen/signup_screen/signup_screen.dart';
import 'package:airline_reveiw/screen/error_screen/error_screen.dart';
import 'package:airline_reveiw/screen/home_page/home_page.dart';
import 'package:airline_reveiw/screen/splash_screen/splash_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String errorScreen = '/errorScreen';
  static const String splashScreen = '/splashScreen';
  static const String homeScreen = '/homeScreen';
  static const String loginScreen = '/loginScreen';
  static const String signupScreen = '/signupScreen';

  static List<GetPage> routes = [
    GetPage(
        name: AppRoutes.errorScreen,
        page: () => ErrorScreen(),
        transition: Transition.rightToLeft),
    GetPage(
      name: AppRoutes.splashScreen,
      page: () => SplashScreen(),
      transition: Transition.rightToLeft,
      middlewares: [InternetCheckMiddleWare()],
    ),
    GetPage(
        name: AppRoutes.homeScreen,
        page: () => HomePage(),
        transition: Transition.rightToLeft,
        middlewares: [InternetCheckMiddleWare()]),
    GetPage(
        name: AppRoutes.loginScreen,
        page: () => LoginScreen(),
        transition: Transition.rightToLeft,
        middlewares: [InternetCheckMiddleWare()]),
    GetPage(
        name: AppRoutes.signupScreen,
        page: () => SignupScreen(),
        transition: Transition.rightToLeft,
        middlewares: [InternetCheckMiddleWare()]),
  ];
}
