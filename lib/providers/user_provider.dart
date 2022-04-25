import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movicolle/authentication.dart';
import 'package:movicolle/model/user_model.dart';
import 'package:provider/provider.dart';
import 'package:movicolle/constants/text_data.dart';

class UserProvider with ChangeNotifier {
  UserModel? userModel;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future fetchUserData() async {
    final userId = _firebaseAuth.currentUser?.uid;
    final docs =
        await _firebaseFirestore.doc('${TextData.usersText}/${userId}').get();
    final userModels = UserModel(
      uid: userId,
      name: docs.data()!['name'],
      email: docs.data()!['email'],
      localPath: docs.data()!['localPath'],
      remotePath: docs.data()!['remotePath'],
    );
    userModel = userModels;
    notifyListeners();
  }
}
