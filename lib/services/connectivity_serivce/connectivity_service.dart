import 'dart:async';

import 'package:airline_reveiw/core/app_route/app_route.dart';
import 'package:airline_reveiw/widget/app_log/app_error_log.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ConnectivityService extends GetxController {
  RxList<ConnectivityResult> connectionStatus = <ConnectivityResult>[].obs;
  final Connectivity connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> connectivitySubscription;

  Future<void> initConnectivity() async {
    try {
      List<ConnectivityResult> result = await connectivity.checkConnectivity();
      _updateConnectionStatus(result);
      connectivitySubscription = connectivity.onConnectivityChanged.listen((event) {
        _updateConnectionStatus(event);
      });
    } on PlatformException catch (e) {
      errorLog('Couldn\'t check connectivity status', e);
    }
  }

  void _updateConnectionStatus(List<ConnectivityResult> result) {
    try {
      connectionStatus.value = result;
      connectionStatus.refresh();
      if (result.contains(ConnectivityResult.none)) {
        Future.microtask(() {
          if (Get.isRegistered<GetMaterialApp>()) {
            Get.offAllNamed(AppRoutes.errorScreen);
          }
        });
      }
    } catch (e) {
      errorLog("_updateConnectionStatus", e);
    }
  }

  @override
  void onInit() {
    super.onInit();
    initConnectivity();
  }

  @override
  void onClose() {
    connectivitySubscription.cancel();
    super.onClose();
  }
}