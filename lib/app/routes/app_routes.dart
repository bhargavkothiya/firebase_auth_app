import 'package:firebase_auth_app/presentation/screens/auth_check_screen.dart';
import 'package:firebase_auth_app/presentation/screens/home_screen.dart';
import 'package:firebase_auth_app/presentation/screens/home_scren_user_data.dart';
import 'package:get/get.dart';

import '../../presentation/bindings/home_bindings.dart';
import '../../presentation/bindings/login_bindings.dart';
import '../../presentation/screens/login_screen.dart';

abstract class AppRoutes {
  static const login = '/login';
  static const firebaseHome = '/home';
  static const homeWithData = '/homeWithData';
  static const authCheckScreen = '/authCheckScreen';

  static final List<GetPage> routes = [
    GetPage(
      name: login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: firebaseHome,
      page: () => const FireBaseHomeScreen(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: homeWithData,
      page: () => const HomeScreenUserData(),
      binding: HomeBindings(),
    ),
    GetPage(name: authCheckScreen, page: () => const AuthCheckScreen()),
  ];
}
