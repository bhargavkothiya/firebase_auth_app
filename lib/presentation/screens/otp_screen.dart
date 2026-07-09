import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_app/presentation/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;

  const OtpScreen({
    super.key,
    required this.verificationId,
    required this.phoneNumber,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  var code = "";

  signIn() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: widget.verificationId,
      smsCode: code,
    );

    try {
      await FirebaseAuth.instance.signInWithCredential(credential).then((
        value,
      ) {
        Get.offAll(Wrapper());
      });
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.code);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Pinput(
            length: 6,
            onChanged: (value) {
              setState(() {
                code = value;
              });
            },
          ),
          ElevatedButton(
            onPressed: () {
              signIn();
            },
            child: Text("Verify OTP"),
          ),
        ],
      ),
    );
  }
}
