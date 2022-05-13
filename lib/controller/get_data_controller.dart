import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movicolle/constants/text_data.dart';

class GetDataController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Object?>>? getDataStream() {
    return _firestore
        .collection(TextData.postsText)
        .orderBy(TextData.dateText)
        .snapshots();
  }

  Future<List<Map<String, dynamic>>> getData() async {
    List<Map<String, dynamic>> postsList = [];
    final postsData = await _firestore.collection(TextData.postsText).get();
    for (int i = 0; i < postsData.docs.length; i++) {
      postsList.add(postsData.docs[i].data());
      postsList[i]['uid'] = postsData.docs[i].id;
    }
    return postsList;
  }
}
