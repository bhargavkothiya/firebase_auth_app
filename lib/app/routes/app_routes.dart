import 'package:get/get.dart';

import '../../presentation/bindings/login_bindings.dart';
import '../../presentation/screens/login_screen.dart';

class AppRoutes {
  static const login = '/login';
  static const home = '/home';

  static final routes = [
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
  ];
}
