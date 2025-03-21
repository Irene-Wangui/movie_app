import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smokeless_movies/pages/auth/sign_in_page.dart';
import 'package:smokeless_movies/pages/landing_page.dart';

class AuthController extends GetxController {
  final isloadingAuth = false.obs;
  @override
  void onInit() {
    super.onInit();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        log('User is currently signed out!');
        isloadingAuth.value = false;
      } else {
        log('User is signed in!');
        isloadingAuth.value = false;
        Get.off((page) => LandingPage());
      }
    });
  }

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

  Future<void> Signout() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    Get.offAll(() => SignInPage());
  }
}
