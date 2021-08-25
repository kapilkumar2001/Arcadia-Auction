import 'package:arcadia/constants/app_theme.dart';
import 'package:flutter/material.dart';

class MatchDetails extends StatefulWidget {
  static const routeName = '/match-details';
  const MatchDetails({Key? key}) : super(key: key);

  @override
  _MatchDetailsState createState() => _MatchDetailsState();
}

class _MatchDetailsState extends State<MatchDetails> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Match 1"),
        backgroundColor: CustomColors.primaryColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: CustomColors.primaryColor,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(children: [
                    CircleAvatar(
                      minRadius: 50,
                      maxRadius: 50,
                      child: Image.network(
                          "https://upload.wikimedia.org/wikipedia/en/thumb/2/2b/Chennai_Super_Kings_Logo.svg/1200px-Chennai_Super_Kings_Logo.svg.png"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Team 1",
                      style: TextStyle(color: Colors.amberAccent, fontSize: 20),
                    )
                  ]),
                  Text(
                    "Vs",
                    style: TextStyle(fontSize: 20, color: Colors.blueAccent),
                  ),
                  Column(children: [
                    CircleAvatar(
                      minRadius: 50,
                      maxRadius: 50,
                      child: Image.network(
                          "https://upload.wikimedia.org/wikipedia/en/thumb/2/2b/Chennai_Super_Kings_Logo.svg/1200px-Chennai_Super_Kings_Logo.svg.png"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Team 2",
                      style: TextStyle(color: Colors.amberAccent, fontSize: 20),
                    )
                  ]),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
