import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/home_controller.dart';

class HomeScreenUserData extends GetView<HomeController> {
  const HomeScreenUserData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              controller.logOut();
            },
            icon: Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final user = controller.user.value;

        if (user == null) {
          return const Center(child: Text("No Data Found"));
        }

        return EasyRefresh(
          onRefresh: controller.refreshData,

          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: RefreshIndicator(
              color: Colors.blue,
              displacement: 100,
              onRefresh: () {
                return controller.refreshData();
              },
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

                  _infoTile("Email", user.email),
                  _infoTile("Phone", user.phone),
                  _infoTile("Age", "${user.age}"),
                  _infoTile("Gender", user.gender),
                  _infoTile("Birth Date", user.birthDate),
                  _infoTile("Blood Group", user.bloodGroup),
                  _infoTile("Height", "${user.height} cm"),
                  _infoTile("Weight", "${user.weight} kg"),
                  _infoTile("Eye Color", user.eyeColor),

                  const Divider(height: 35),

                  const Text(
                    "Address",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),

                  _infoTile("Address", user.address?.address),
                  _infoTile("City", user.address?.city),
                  _infoTile("State", user.address?.state),
                  _infoTile("Country", user.address?.country),
                  _infoTile("Postal Code", user.address?.postalCode),

                  const Divider(height: 35),

                  const Text(
                    "Company",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),

                  _infoTile("Company", user.company?.name),
                  _infoTile("Department", user.company?.department),
                  _infoTile("Designation", user.company?.title),

                  const Divider(height: 35),

                  const Text(
                    "Bank",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),

                  _infoTile("Card Number", user.bank?.cardNumber),
                  _infoTile("Card Type", user.bank?.cardType),
                  _infoTile("Currency", user.bank?.currency),
                  _infoTile("IBAN", user.bank?.iban),

                  const Divider(height: 35),

                  const Text(
                    "Crypto",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),

                  _infoTile("Coin", user.crypto?.coin),
                  _infoTile("Wallet", user.crypto?.wallet),
                  _infoTile("Network", user.crypto?.network),

                  const Divider(height: 35),

                  _infoTile("University", user.university),
                  _infoTile("Role", user.role),
                ],
              ),
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
      child: ListTile(title: Text(title), subtitle: Text(value ?? "N/A")),
    );
  }
}
