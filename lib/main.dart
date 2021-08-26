import 'package:arcadia/provider/announcements.dart';
import 'package:arcadia/provider/auth.dart';
import 'package:arcadia/provider/matches.dart';
import 'package:arcadia/provider/players.dart';
import 'package:arcadia/provider/teams.dart';
import 'package:arcadia/screens/Auction/auction_details.dart';
import 'package:arcadia/screens/Auction/auction_overview.dart';
import 'package:arcadia/screens/Auction/auction_player.dart';
import 'package:arcadia/screens/Player/PlayerScreens/schedule_screen.dart';
import 'package:arcadia/screens/Player/PlayerScreens/team_details.dart';
import 'package:arcadia/screens/onBoardingScreen.dart';
import 'package:arcadia/screens/wrapper.dart';
import 'package:arcadia/screens/Auction/auction_home.dart';
import 'package:arcadia/screens/signin_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'constants/app_theme.dart';
import 'screens/Auction/auction_resell_player.dart';
import 'screens/Player/PlayerScreens/player_profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<void> initialiseFirebase() async {
    await Firebase.initializeApp();
  }

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
            primaryColor: CustomColors.primaryColor,
            // primarySwatch: Colors.purple,
            accentColor: CustomColors.secondaryColor,
            // fontFamily: 'lato',
             textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
          ),
          home: FutureBuilder(
            // Initialize FlutterFire:
            future: initialiseFirebase(),
            builder: (context, snapshot) {
              // Once complete, show your application
              if (snapshot.connectionState == ConnectionState.done) {
                if (auth.isAuth) {
                  // Provider.of<Auth>(context).checkAndSetAuth();
                  return Wrapper();
                } else {
                  return OnboardingScreen();
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
            TeamDetails.routeName: (ctx) => TeamDetails(),
            ScheduleScreen.routeName: (ctx) => ScheduleScreen(),
            PlayerProfileScreen.routeName: (ctx) => PlayerProfileScreen(),
            SignInScreen.routeName: (ctx)=>SignInScreen(),
          },
        ),
      ),
    );
  }
}



