import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class NotificationsController extends GetxController {
  static NotificationsController get to => Get.find();
  final isloadingAuth = true.obs;
  @override
  void onInit() {
    super.onInit();
    log('notifications contrioller initialized');
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Got a message whilst in the foreground!');
      log('Message data: ${message.data}');

      if (message.notification != null) {
        log('Message also contained a notification: ${message.notification}');
      }
    });
  }
}
