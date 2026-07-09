import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_app/presentation/screens/forget_password_screen.dart';
import 'package:firebase_auth_app/presentation/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passWordController = TextEditingController();

  Login({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.code, snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignInAccount? user = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication userAuth = await user!.authentication;

    final cred = GoogleAuthProvider.credential(
      accessToken: userAuth.accessToken,
      idToken: userAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(cred);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign In")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(height: 50),
            TextField(
              decoration: InputDecoration(hintText: "Email"),
              controller: emailController,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Password"),
              controller: passWordController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(ForgetPasswordScreen());
                  },
                  child: Text("forget Password"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.to(SignUpScreen());
                  },
                  child: Text("Sign Up"),
                ),
                SizedBox(width: 25),
                ElevatedButton(
                  onPressed: () async {
                    await Login(
                      email: emailController.text.trim(),
                      password: passWordController.text.trim(),
                    );
                  },
                  child: Text("Login"),
                ),
              ],
            ),
            SizedBox(height: 25),

            ElevatedButton(
              onPressed: () {
                signInWithGoogle();
              },
              child: Text("Google Sign In"),
            ),
          ],
        ),
      ),
    );
  }
}
