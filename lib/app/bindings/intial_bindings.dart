import 'package:firebase_auth_app/core/storage/secure_storage_service.dart';
import 'package:get/get.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SecureStorageService(), permanent: true);
  }
}
