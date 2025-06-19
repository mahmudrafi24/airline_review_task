import 'package:airline_reveiw/services/connectivity_serivce/connectivity_service.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ConnectivityService());
  }
}
