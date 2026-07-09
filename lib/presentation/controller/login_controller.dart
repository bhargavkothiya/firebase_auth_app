import 'package:firebase_auth_app/data/repositories/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final AuthRepository repository;

  LoginController({required this.repository});

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final RxBool isLoading = false.obs;

  @override
  void onClose() {
    // TODO: implement onClose
    usernameController.dispose();
    passwordController.dispose();
  }

  Future<void> login() async {
    isLoading.value = true;
    try {
      final user = await repository.login(
        username: usernameController.text.trim(),
        password: passwordController.text.trim(),
      );
    } catch (e) {
      Get.snackbar("Login Failed", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
