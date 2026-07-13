import 'package:firebase_auth_app/core/service/secure_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../../../core/constant/storage_keys.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = SecureStorageService();
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text("English"),
            onTap: () {
              Get.updateLocale(const Locale("en", "US"));
              Get.back();
            },
          ),

          ListTile(
            title: const Text("हिन्दी"),
            onTap: () async {
              Get.updateLocale(const Locale("hi", "IN"));
              await storage.write(key: StorageKeys.language, value: "hi");
              Get.back();
            },
          ),

          ListTile(
            title: const Text("ગુજરાતી"),
            onTap: () {
              Get.updateLocale(const Locale("gu", "IN"));

              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
