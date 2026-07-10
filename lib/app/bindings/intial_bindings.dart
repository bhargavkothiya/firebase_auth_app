import 'package:firebase_auth_app/core/service/connectivity_service.dart';
import 'package:firebase_auth_app/core/service/secure_storage_service.dart';
import 'package:get/get.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SecureStorageService(), permanent: true);
    Get.put(ConnectivityService(), permanent: true);
  }
}
