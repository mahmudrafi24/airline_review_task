// ignore: file_names
import 'package:airline_reveiw/core/app_route/app_route.dart';
import 'package:airline_reveiw/screen/error_screen/error_screen.dart';
import 'package:airline_reveiw/services/connectivity_serivce/connectivity_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InternetCheckMiddleWare extends GetMiddleware {
  final ConnectivityService connectivityService =
      Get.find<ConnectivityService>();

  @override
  RouteSettings? redirect(String? route) {
    if (connectivityService.connectionStatus
        .contains(ConnectivityResult.none)) {
      return RouteSettings(name: AppRoutes.errorScreen);
    }
    return super.redirect(route);
  }

  @override
  GetPage? onPageCalled(GetPage? page) {
    if (connectivityService.connectionStatus
        .contains(ConnectivityResult.none)) {
      return GetPage(name: AppRoutes.errorScreen, page: () => ErrorScreen());
    }
    return super.onPageCalled(page);
  }

  @override
  GetPageBuilder? onPageBuildStart(GetPageBuilder? page) {
    if (connectivityService.connectionStatus
        .contains(ConnectivityResult.none)) {
      return () => ErrorScreen();
    }
    return super.onPageBuildStart(page);
  }
}
