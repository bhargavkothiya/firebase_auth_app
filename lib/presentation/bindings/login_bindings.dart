import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../../core/network/api_service.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/home_repository.dart';
import '../controller/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService());
    Get.lazyPut<AuthRepository>(() => AuthRepository(apiService: Get.find()));

    Get.lazyPut<LoginController>(() => LoginController(repository: Get.find()));

    Get.lazyPut<HomeRepository>(
      () => HomeRepository(apiService: Get.find(), storage: Get.find()),
    );
  }
}
