import 'package:arcadia/provider/players.dart';
import 'package:arcadia/screens/auction_home.dart';
import 'package:arcadia/screens/auction_overview.dart';
import 'package:arcadia/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    //   home: AuctionOverview(),
    //   routes: {
    //     AuctionOverview.routeName: (ctx) => AuctionOverview(),
    //     AuctionHome.routeName: (ctx) => AuctionHome(),
    //   },
    // );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Players>(
          create: (_) => Players(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AuctionOverview(),
        routes: {
          AuctionOverview.routeName: (ctx) => AuctionOverview(),
          AuctionHome.routeName: (ctx) => AuctionHome(),
        },

        // child: Consumer<Auth>(
        //   builder: (ctx, auth, _) => MaterialApp(
        //     title: 'MyShop',
        //     theme: ThemeData(
        //       primarySwatch: Colors.purple,
        //       accentColor: Colors.deepOrange,
        //       fontFamily: 'lato',
        //     ),
        //     home: auth.isAuth ? ProductsOverviewScreen() : AuthScreen(),
        //     routes: {
        //       ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
        //       CartScreen.routeName: (ctx) => CartScreen(),
        //       OrdersScreen.routeName: (ctx) => OrdersScreen(),
        //       UserProductScreen.routeName: (ctx) => UserProductScreen(),
        //       EditProductScreen.routeName: (ctx) => EditProductScreen(),
        //     },
        // ),
        // ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
