import 'package:firebase_auth_app/app/routes/app_routes.dart';
import 'package:firebase_auth_app/core/exceptions/api_exception.dart';
import 'package:firebase_auth_app/core/service/secure_storage_service.dart';
import 'package:firebase_auth_app/data/repositories/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../core/constant/storage_keys.dart';

class LoginController extends GetxController {
  final AuthRepository repository;
  final storage = SecureStorageService();
  var logger = Logger();

  LoginController({required this.repository});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxBool isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  final RxBool isPasswordVisible = false.obs;

  @override
  void onClose() {
    // TODO: implement onClose
    usernameController.dispose();
    passwordController.dispose();
  }

  String? loginValidator(dynamic value) {
    if (value == null || value.trim().isEmpty) {
      return "Username is required";
    }

    return null;
  }

  String? passValidator(dynamic value) {
    if (value == null || value.trim().isEmpty) {
      return "Password is required";
    }

    if (value.length < 4) {
      return "Password is too short";
    }

    return null;
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    isLoading.value = true;
    try {
      final user = await repository.login(
        username: usernameController.text.trim(),
        password: passwordController.text.trim(),
      );
      await storage.write(
        key: StorageKeys.accessToken,
        value: user.accessToken ?? "",
      );
      Get.offAllNamed(AppRoutes.homeWithData);
    } on ApiException catch (e) {
      Get.snackbar("Error", e.message);
    } catch (e) {
      Get.snackbar("Login Failed", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
