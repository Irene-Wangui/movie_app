import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../my_media_model/media_model.dart';

class FirebaseApis {
  static final db = FirebaseFirestore.instance;

  static Future<void> uploadMyMedia(MymediaModel media) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('user cannot be null');
    }
    media.uid = user.uid;
    if (media.uid == null || media.uid!.isEmpty) {
      throw Exception("User Id cannot be null");
    }
    //create a doc with our id
    DocumentReference ref = db.collection('my_media').doc(media.id);
    //convert our model into map
    Map<String, dynamic> data = media.toMap();
    //upload to firestore
    return ref.set(data);
  }
}
