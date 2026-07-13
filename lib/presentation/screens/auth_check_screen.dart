import 'package:firebase_auth_app/core/constant/storage_keys.dart';
import 'package:firebase_auth_app/core/service/secure_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../app/routes/app_routes.dart';

class AuthCheckScreen extends StatefulWidget {
  const AuthCheckScreen({super.key});

  @override
  State<AuthCheckScreen> createState() => _AuthCheckScreenState();
}

class _AuthCheckScreenState extends State<AuthCheckScreen> {
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  Future<void> checkLogin() async {
    final storage = Get.find<SecureStorageService>();

    final token = await storage.read(key: StorageKeys.accessToken);

    if (token != null && token.isNotEmpty) {
      Get.offAllNamed(AppRoutes.homeWithData);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
