import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:smokeless_movies/controllers/auth_controller.dart';
import 'package:smokeless_movies/pages/landing_page.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: Get.find<AuthController>(),
        builder: (authController) {
          return Center(
            child: authController.isloadingAuth.value
                ? SizedBox(height: 50, width: 50, child: CircularProgressIndicator())
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      Text("sign in",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                          )),
                      SizedBox(height: 24),
                      SignInButton(
                        Buttons.google,
                        onPressed: () {
                          log("want to sign in with google");
                          authController.signInWithGoogle().then((value) {
                            log("sign in page:signed in with google as ${value.user?.displayName}");
                          }).catchError((error, stacktrace) {
                            log("Error signing in with google:$error\n$stacktrace");
                          });
                          log("yay 2!");
                        },
                      ),
                      Spacer(),
                      SizedBox(
                        height: 24,
                      ),
                      TextButton(
                        onPressed: () {
                          log("Skip sign in");
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LandingPage()));
                        },
                        child: Text('Skip >'),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
