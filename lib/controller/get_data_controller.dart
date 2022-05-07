import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movicolle/constants/text_data.dart';

class GetDataController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Object?>>? getData() {
    return _firestore
        .collection(TextData.postsText)
        .orderBy(TextData.dateText)
        .snapshots();
  }
}
