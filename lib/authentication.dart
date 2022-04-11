import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'text_data.dart';

class FirebaseAuthModel {
  static Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final _firestore = FirebaseFirestore.instance;

  Future<User?> signWithGoogle() async {
    User? _user;

    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(credential);
        _user = userCredential.user;
        if (userCredential.additionalUserInfo!.isNewUser) {
          _firestore.collection(TextData.usersText).doc(_user!.uid).set(
            {
              TextData.nameText: _user.displayName,
              TextData.emailText: _user.email,
            },
          );
        }
        return _user;
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  Future signOut() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
  }
}
