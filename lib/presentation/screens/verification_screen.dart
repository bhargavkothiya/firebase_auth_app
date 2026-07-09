import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_app/presentation/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    verifyEmail();
  }

  void verifyEmail() async {
    final user = FirebaseAuth.instance.currentUser;
    await user!.sendEmailVerification().then(
      (value) => Get.snackbar(
        "Done",
        "Verification mail has been sent to your device",
      ),
    );
  }

  reload() async {
    await FirebaseAuth.instance.currentUser!.reload().then(
      (value) => Get.offAll(Wrapper()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Verification")),
      body: Center(child: Text("Verification mail as been sent to your mail")),
      floatingActionButton: IconButton(
        onPressed: () {
          reload();
        },
        icon: Icon(Icons.refresh),
      ),
    );
  }
}
