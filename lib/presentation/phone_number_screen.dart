import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'otp_screen.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final TextEditingController phoneNumberController = TextEditingController();

  Future<void> sendCode() async {
    try {
      final phoneNumber = "+91${phoneNumberController.text.trim()}";

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (phoneAuthCredential) {},
        verificationFailed: (e) {
          Get.snackbar("Error", e.code);
        },
        codeSent: (verificationId, forceResendingToken) {
          Get.to(
            OtpScreen(verificationId: verificationId, phoneNumber: phoneNumber),
          );
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.code);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(height: 100),
            TextField(
              controller: phoneNumberController,
              decoration: InputDecoration(hintText: "Enter Phone Number"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                sendCode();
              },
              child: Text("Receive OTP"),
            ),
          ],
        ),
      ),
    );
  }
}
