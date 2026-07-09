import 'package:firebase_auth_app/data/repositories/home_repository.dart';
import 'package:get/get.dart';

import '../../data/model/user_response_modal.dart';

class HomeController extends GetxController {
  final RxBool isLoading = false.obs;
  final HomeRepository repository;
  final Rxn<UserResponseModel> user = Rxn<UserResponseModel>();

  HomeController({required this.repository});

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
}
