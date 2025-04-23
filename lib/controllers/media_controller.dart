import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:smokeless_movies/my_media_model/media_model.dart';
import 'package:smokeless_movies/utils/firebase_apis.dart';

class MediaController extends GetxController {
  var isBookMarked = false.obs;
  FirebaseFirestore db = FirebaseFirestore.instance;

  var myMedia = <MymediaModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    fetchMyMedia();
  }

  Future<void> fetchMediaDetails(String mediaType, String id) async {
    DocumentSnapshot movieSnapshot = await db.collection('my_media').doc("$mediaType-$id").get();
    isBookMarked.value = movieSnapshot.exists;
    log("fetched movie $id: ${movieSnapshot.data()}");
  }

  Future<void> toggle(MymediaModel mymediamodel) async {
    if (isBookMarked.value) {
      await db.collection('my_media').doc(mymediamodel.id).delete();
      isBookMarked.value = false;
      update();
    } else {
      await FirebaseApis.uploadMyMedia(mymediamodel);
      isBookMarked.value = true;
      update();
    }
  }

  Future<void> fetchMyMedia() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("User is not logged in");
    }
    await db.collection("my_media").where("uid", isEqualTo: user.uid).get().then((querySnapshot) {
      myMedia.value = querySnapshot.docs
          .map(
            (doc) => MymediaModel.fromMap(
              doc.data(),
            ),
          )
          .toList();
      update();
    });
    log("${myMedia.where((e) => e.mediaType == "movie").length} movies");
  }
}
