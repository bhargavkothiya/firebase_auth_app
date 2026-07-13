import 'package:firebase_auth_app/app/routes/app_routes.dart';
import 'package:firebase_auth_app/core/localization/app_translation.dart';
import 'package:firebase_auth_app/core/widgets/network_listener.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/bindings/intial_bindings.dart';
import 'core/theme/dark_theme.dart';
import 'core/theme/light_theme.dart' as AppTheme;
import 'core/theme/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Get.put(ThemeController(), permanent: true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeController themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        locale: const Locale("en", "US"),
        fallbackLocale: const Locale("en", "US"),
        translations: AppTranslation(),
        darkTheme: darkTheme,
        theme: AppTheme.lightTheme,
        themeMode: themeController.themeMode.value,
        builder: (context, child) {
          return NetworkListener(child: child!);
        },

        getPages: AppRoutes.routes,
        initialRoute: AppRoutes.authCheckScreen,
        initialBinding: InitialBindings(),
      );
    });
  }
}
