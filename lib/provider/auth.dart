import 'package:arcadia/exceptions/http_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth with ChangeNotifier {
  static String? uid;

  bool get isAuth {
    User? user = FirebaseAuth.instance.currentUser;
    return user == null ? false : true;
  }

  // bool checkAndSetAuth() {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   uid = FirebaseAuth.instance.currentUser!.uid.toString();
  //   return user == null ? false : true;
  // }

  static Future<User?> signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
        uid = FirebaseAuth.instance.currentUser!.uid.toString();
      } on FirebaseAuthException catch (e) {
        throw HttpException(e.code);
      }
    }
    return user;
  }

  Future<void> signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
      uid = null;
    } catch (e) {}
  }
}
