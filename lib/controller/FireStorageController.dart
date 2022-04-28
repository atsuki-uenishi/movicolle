import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:movicolle/constants/text_data.dart';
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:movicolle/providers/user_provider.dart';

class FireStorageController {
  static Future<void> uploadFile(
      String sourcePath, String uploadFileName) async {
    final FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref =
        storage.ref().child(TextData.imagesText).child('/$uploadFileName');
    File file = File(sourcePath);

    try {
      await ref.putFile(file);
    } catch (FirebaseException) {
      print(FirebaseException);
    }
  }

  static Future<void> addFilePath(
      String? userId, String localPath, String remotePath) async {
    CollectionReference users =
        FirebaseFirestore.instance.collection(TextData.usersText);
    await users.doc(userId).set({
      TextData.localPathText: localPath,
      TextData.remotePathText: remotePath,
    }, SetOptions(merge: true));
  }

  static Future<ImageProvider?> getImgs(
      String imgPathLocal, String imgPathRemote) async {
    String? imgPathUse;
    bool existLocal = await File(imgPathLocal).existsSync();
    if (existLocal) {
      imgPathUse = imgPathLocal;
      return FileImage(File(imgPathUse));
    } else {
      try {
        imgPathUse = await FirebaseStorage.instance
            .ref()
            .child(imgPathRemote)
            .getDownloadURL();
        return NetworkImage(imgPathUse);
      } catch (FirebaseException) {
        return null;
      }
    }
  }
}
