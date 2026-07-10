import 'package:firebase_auth_app/app/routes/app_routes.dart';
import 'package:firebase_auth_app/core/constant/storage_keys.dart';
import 'package:firebase_auth_app/core/service/secure_storage_service.dart';
import 'package:firebase_auth_app/data/repositories/home_repository.dart';
import 'package:get/get.dart';

import '../../data/model/user_response_modal.dart';

class HomeController extends GetxController {
  final RxBool isLoading = false.obs;
  final HomeRepository repository;
  final Rxn<UserResponseModel> user = Rxn<UserResponseModel>();
  final SecureStorageService storage;

  HomeController({required this.repository, required this.storage});

  @override
  void onInit() {
    super.onInit();
    profileData();
  }

  Future<void> profileData() async {
    isLoading.value = true;

    try {
      user.value = await repository.fetchData();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshData() async {
    await profileData();
  }

  void logOut() async {
    await storage.delete(key: StorageKeys.accessToken);
    await storage.delete(key: StorageKeys.refreshToken);
    Get.offAllNamed(AppRoutes.login);
  }
}
