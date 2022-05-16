import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movicolle/constants/text_data.dart';

class PostController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> postData(String userId, String tittle, String date, int rating,
      String impression, String? posterUrl) async {
    try {
      _firebaseFirestore.collection(TextData.postsText).doc().set(
        {
          TextData.userIdText: userId,
          TextData.tittleText: tittle,
          TextData.dateText: date,
          TextData.ratingText: rating,
          TextData.impressionText: impression,
          TextData.posterUrlText: posterUrl,
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> changePostData(int rating, String impression, String uid) async {
    try {
      _firebaseFirestore.collection(TextData.postsText).doc(uid).set({
        TextData.ratingText: rating,
        TextData.impressionText: impression,
      }, SetOptions(merge: true));
    } catch (e) {
      print(e);
    }
  }

  Future<void> deletePostData(String uid) async {
    try {
      _firebaseFirestore.collection(TextData.postsText).doc(uid).delete();
    } catch (e) {
      print(e);
    }
  }
}
