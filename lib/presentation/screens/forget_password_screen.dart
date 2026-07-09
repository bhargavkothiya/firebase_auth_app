import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController forgetPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Forget Password Screen")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(hintText: "Enter Email"),
              controller: forgetPasswordController,
            ),

            ElevatedButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.sendPasswordResetEmail(
                    email: forgetPasswordController.text,
                  );
                  Get.snackbar(
                    "Send",
                    "Verification mail has been sent to your email",
                  );
                  forgetPasswordController.clear();
                } catch (e) {
                  Get.snackbar("Error", e.toString());
                }
              },
              child: Text("Send Verification Mail"),
            ),
          ],
        ),
      ),
    );
  }
}
