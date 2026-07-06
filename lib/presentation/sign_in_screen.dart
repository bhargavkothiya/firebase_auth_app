import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passWordController = TextEditingController();

  Login({required String email, required String password}) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign In")),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(hintText: "Email"),
            controller: emailController,
          ),
          TextField(
            decoration: InputDecoration(hintText: "Password"),
            controller: passWordController,
          ),
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
    );
  }
}
