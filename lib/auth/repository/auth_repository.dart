import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  

  Future<bool> checkUserProfile(String uid) async {
    DocumentReference<Map<String, dynamic>> gameRoomRef =
        FirebaseFirestore.instance.collection('profiles').doc(uid);

    DocumentSnapshot<Map<String, dynamic>> profileSnapshot =
        await gameRoomRef.get();
        
    return profileSnapshot.data()!.isNotEmpty;
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await _firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();
    } catch (e) {
      log(e.toString());
    }
  }

  User? getCurrentUser() {
    final user = _firebaseAuth.currentUser;
    return user;
  }
}
