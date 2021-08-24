import 'package:arcadia/provider/announcements.dart';
import 'package:arcadia/provider/auth.dart';
import 'package:arcadia/provider/matches.dart';
import 'package:arcadia/provider/players.dart';
import 'package:arcadia/provider/teams.dart';
import 'package:arcadia/screens/Auction/auction_details.dart';
import 'package:arcadia/screens/Auction/auction_overview.dart';
import 'package:arcadia/screens/Auction/auction_player.dart';
import 'package:arcadia/screens/wrapper.dart';
import 'package:arcadia/screens/Auction/auction_home.dart';
import 'package:arcadia/screens/signin_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants/app_theme.dart';
import 'screens/Auction/auction_resell_player.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Players>(
          create: (_) => Players(),
        ),
         ChangeNotifierProvider<Matches>(
          create: (_) => Matches(),
        ),
        ChangeNotifierProvider<Teams>(
          create: (_) => Teams(),
        ),
        ChangeNotifierProvider<Auth>(
          create: (_) => Auth(),
        ),
        ChangeNotifierProvider<Announcements>(
          create: (_) => Announcements(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Arcadia CSGO League',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'lato',
          ),
          home: FutureBuilder(
            // Initialize FlutterFire:
            future: _initialization,
            builder: (context, snapshot) {
              // Once complete, show your application
              if (snapshot.connectionState == ConnectionState.done) {
                if (auth.isAuth) {
                  Provider.of<Auth>(context).checkAndSetAuth();
                  return Wrapper();
                } else {
                  return OnboardingPage();
                }
              }
              return CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  CustomColors.firebaseOrange,
                ),
              );
            },
          ),
          routes: {
            AuctionOverview.routeName: (ctx) => AuctionOverview(),
            AuctionHome.routeName: (ctx) => AuctionHome(),
            AuctionPlayer.routeName: (ctx) => AuctionPlayer(),
            AuctionPlayerResell.routeName: (ctx) => AuctionPlayerResell(),
            AuctionDetails.routeName: (ctx) => AuctionDetails(),
          },
        ),
      ),
    );
  }
}

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arcadia CSGO League',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      home: SignInScreen(),
    );
  }
}
