import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ThemeController extends GetxController {
  final themeMode = ThemeMode.light.obs;

  RxBool isDark = false.obs;

  void changeTheme(bool value) {
    isDark.value = value;

    themeMode.value = value ? ThemeMode.dark : ThemeMode.light;

    Get.changeThemeMode(themeMode.value);
  }
}
