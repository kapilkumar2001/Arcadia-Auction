import 'package:arcadia/exceptions/http_exception.dart';
import 'package:arcadia/screens/userprofile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth with ChangeNotifier {
  String? uid;

  bool get isAuth {
    User? user = FirebaseAuth.instance.currentUser;
    return user == null ? false : true;
  }

  // static Future<FirebaseApp> initializeFirebase(
  //     {required BuildContext context}) async {
  //   FirebaseApp firebaseApp = await Firebase.initializeApp();

  //   User? user = FirebaseAuth.instance.currentUser;

  //   if (user != null) {
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(
  //         builder: (context) => UserProfileScreen(
  //           user: user,
  //         ),
  //       ),
  //     );
  //   }

  //   return firebaseApp;
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
      } on FirebaseAuthException catch (e) {
        // if (e.code == 'account-exists-with-different-credential') {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     Auth.customSnackBar(
        //       content:
        //           'The account already exists with a different credential.',
        //     ),
        //   );
        // } else if (e.code == 'invalid-credential') {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     Auth.customSnackBar(
        //       content: 'Error occurred while accessing credentials. Try again.',
        //     ),
        //   );
        // }
        throw HttpException(e.code);
      }
      // } catch (e) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     Auth.customSnackBar(
      //       content: 'Error occurred using Google Sign-In. Try again.',
      //     ),
      //   );
      // }
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
    } catch (e) {}
    notifyListeners();
  }
}
