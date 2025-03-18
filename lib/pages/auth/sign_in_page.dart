import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:smokeless_movies/widgets/landing_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
              signInWithGoogle().then(
                (value) {
                  log("signed in with google as ${value.user?.displayName}");
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LandingPage()));
                },
              ).catchError((error, stacktrace) {
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
        ]),
      ),
    );
  }
}
