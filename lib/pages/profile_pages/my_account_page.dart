import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:smokeless_movies/controllers/auth_controller.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({super.key});

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  User? user = FirebaseAuth.instance.currentUser;
  final authcontroller = Get.find<AuthController>();

  Future<void> showSignOutDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Sign Out"),
          content: Text("Are you sure you want to sign out?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                authcontroller.Signout();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('You have been signed out.')),
                );
              },
              child: Text("Sign Out"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Scaffold(
        body: Center(
          child: Text("No user logged in. Please sign in."),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("My Account"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Profile picture with a fallback image if no URL is available
            CircleAvatar(
              radius: 50,
              backgroundImage: CachedNetworkImageProvider(
                user?.photoURL ?? "https://www.example.com/default-avatar.png",
              ),
            ),
            SizedBox(height: 16),
            // Display the user's name and email
            Text(
              user?.displayName ?? "No Name Provided",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              user?.email ?? "No Email Provided",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 16),

            ElevatedButton(
              onPressed: showSignOutDialog,
              child: Text("Sign Out"),
            ),
          ],
        ),
      ),
    );
  }
}
