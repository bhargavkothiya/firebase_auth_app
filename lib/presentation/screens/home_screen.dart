import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireBaseHomeScreen extends StatefulWidget {
  const FireBaseHomeScreen({super.key});

  @override
  State<FireBaseHomeScreen> createState() => _FireBaseHomeScreenState();
}

class _FireBaseHomeScreenState extends State<FireBaseHomeScreen> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Homepage")),
      // body: Padding(
      //   padding: EdgeInsetsGeometry.symmetric(horizontal: 15),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       !user!.phoneNumber!.isNotEmpty
      //           ? Text("Email : ${user!.email}")
      //           : Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Text("Phone Number : ${user!.phoneNumber}"),
      //                 Text("UID : ${user!.uid}"),
      //               ],
      //             ),
      //       SizedBox(height: 25),
      //       Text("Email Varified : ${user!.emailVerified}"),
      //     ],
      //   ),
      // ),
      floatingActionButton: ElevatedButton(
        onPressed: () async {
          await GoogleSignIn().signOut();
          await FirebaseAuth.instance.signOut();
        },
        child: Text("Sign Out"),
      ),
    );
  }
}
