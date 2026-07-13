import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/theme_controller.dart';
import '../controller/home_controller.dart';
import 'home_screen_with_data/widget/lanuage_bottom_Sheet.dart';

class HomeScreenUserData extends GetView<HomeController> {
  const HomeScreenUserData({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Text("Settings")),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text("language".tr),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Get.back();
                Get.bottomSheet(const LanguageBottomSheet());
              },
            ),
            Obx(() {
              return SwitchListTile(
                value: themeController.isDark.value,
                onChanged: themeController.changeTheme,
                title: Text("dark_mode".tr),
              );
            }),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("profile".tr),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              controller.logOut();
            },
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final user = controller.user.value;

        if (user == null) {
          return Center(child: Text("no_data_found".tr));
        }

        return EasyRefresh(
          onRefresh: controller.refreshData,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 55,
                  backgroundImage: NetworkImage(user.image ?? ""),
                ),

                const SizedBox(height: 20),

                Text(
                  "${user.firstName} ${user.lastName}",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  "@${user.username}",
                  style: const TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 20),

                _infoTile("email".tr, user.email),
                _infoTile("phone".tr, user.phone),
                _infoTile("age".tr, "${user.age}"),
                _infoTile("gender".tr, user.gender),
                _infoTile("birth_date".tr, user.birthDate),
                _infoTile("blood_group".tr, user.bloodGroup),
                _infoTile("height".tr, "${user.height} cm"),
                _infoTile("weight".tr, "${user.weight} kg"),
                _infoTile("eye_color".tr, user.eyeColor),

                const Divider(height: 35),

                Text(
                  "address".tr,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                _infoTile("address".tr, user.address?.address),
                _infoTile("city".tr, user.address?.city),
                _infoTile("state".tr, user.address?.state),
                _infoTile("country".tr, user.address?.country),
                _infoTile("postal_code".tr, user.address?.postalCode),

                const Divider(height: 35),

                Text(
                  "company".tr,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                _infoTile("company".tr, user.company?.name),
                _infoTile("department".tr, user.company?.department),
                _infoTile("designation".tr, user.company?.title),

                const Divider(height: 35),

                Text(
                  "bank".tr,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                _infoTile("card_number".tr, user.bank?.cardNumber),
                _infoTile("card_type".tr, user.bank?.cardType),
                _infoTile("currency".tr, user.bank?.currency),
                _infoTile("iban".tr, user.bank?.iban),

                const Divider(height: 35),

                Text(
                  "crypto".tr,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                _infoTile("coin".tr, user.crypto?.coin),
                _infoTile("wallet".tr, user.crypto?.wallet),
                _infoTile("network".tr, user.crypto?.network),

                const Divider(height: 35),

                _infoTile("university".tr, user.university),
                _infoTile("role".tr, user.role),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _infoTile(String title, String? value) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(title: Text(title), subtitle: Text(value ?? "na".tr)),
    );
  }
}
