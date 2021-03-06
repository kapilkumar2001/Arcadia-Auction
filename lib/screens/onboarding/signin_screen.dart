import 'package:arcadia/constants/app_theme.dart';
import 'package:arcadia/widgets/anon_signin_button.dart';
import 'package:arcadia/widgets/google_sign_in_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = '/sign-in';
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.firebaseNavy,
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          bottom: 20.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 1,
                    child: Image.asset(
                      'assets/arcadia-logo3.png',
                      height: 250,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Arcadia',
                    style: TextStyle(
                      color: CustomColors.firebaseYellow,
                      fontSize: 40,
                    ),
                  ),
                  Text(
                    'CSGO League',
                    style: TextStyle(
                      color: CustomColors.firebaseOrange,
                      fontSize: 40,
                    ),
                  ),
                ],
              ),
            ),
            GoogleSignInButton(),
            AnonSignInButton(),
          ],
        ),
      ),
    );
  }
}
