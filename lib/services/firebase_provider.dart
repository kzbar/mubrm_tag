import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mubrm_tag/model/social_media.dart';

class FirebaseProvider {

  static listenToMedias(callback, userId) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots()
        .listen((qs) {
      final socialMedia = mapQueryToMedia(qs);
      callback(socialMedia);
    });
  }

  static mapQueryToMedia(DocumentSnapshot qs) {
    return SocialMedia.fromJsonFireStore(qs.data()['socialMediaSelected'],qs.id);
  }
}