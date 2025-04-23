import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smokeless_movies/controllers/notifications_controller.dart';
import 'package:smokeless_movies/pages/auth/sign_in_page.dart';
import 'package:smokeless_movies/pages/landing_page.dart';

class AuthController extends GetxController {
  final isloadingAuth = false.obs;
  NotificationsController notificationsController = Get.put(NotificationsController(), permanent: true);
  @override
  void onInit() {
    super.onInit();
    getFcmToken();
    listenToTokenRefresh();
    log('landing page initializing...');
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        log('User is currently signed out!');
        isloadingAuth.value = false;
      } else {
        isloadingAuth.value = false;
        Get.off(() => LandingPage());
      }
    });
  }

  void getFcmToken() async {
    final db = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      log("User not logged in. Cannot upload FCM token.");
      return;
    }

    try {
      final fcmToken = await FirebaseMessaging.instance.getToken();
      log("Initial FCM Token: $fcmToken");

      if (fcmToken != null) {
        await db.collection('users').doc(user.uid).update({
          'fcmToken': fcmToken,
        });
        log("FCM Token updated in Firestore.");
      }
    } catch (e) {
      log("Error getting or updating FCM token: $e");
    }
  }

  void listenToTokenRefresh() {
    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
      log("FCM Token refreshed: $fcmToken");
    }).onError((err) {
      log("Error on token refresh: $err");
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
