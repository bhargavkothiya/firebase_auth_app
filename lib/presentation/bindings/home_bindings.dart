import 'package:get/get.dart';

import '../../core/network/api_service.dart';
import '../../data/repositories/home_repository.dart';
import '../controller/home_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService(storage: Get.find()));
    Get.lazyPut<HomeRepository>(
      () => HomeRepository(apiService: Get.find(), storage: Get.find()),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(repository: Get.find(), storage: Get.find()),
    );
  }
}
