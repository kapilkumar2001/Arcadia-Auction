import 'package:arcadia/constants/app_theme.dart';
import 'package:arcadia/provider/matches.dart';
import 'package:arcadia/provider/player.dart';
import 'package:arcadia/provider/players.dart';
import 'package:arcadia/provider/team.dart';
import 'package:arcadia/provider/match.dart';
import 'package:arcadia/provider/teams.dart';
import 'package:arcadia/widgets/player_card.dart';
import 'package:arcadia/widgets/upcoming_match_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TeamDetails extends StatefulWidget {
  static const routeName = '/team-details';
 
  @override
  _TeamDetailsState createState() => _TeamDetailsState();
}

class _TeamDetailsState extends State<TeamDetails> {
  bool _isInit = true;
  bool _isLoading = true;
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_isInit) {
      await Provider.of<Players>(context, listen: false).fetchAndSetPlayers();
      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    Team team = ModalRoute.of(context)!.settings.arguments as Team;
    List<Player> players =
        Provider.of<Players>(context).getTeamPlayer(team.teamUid);
    List<Match> upcomingMatchList = Provider.of<Matches>(
      context,
      listen: false,
    ).upcomingMatches.where((e) {
      return e.teamId1 == team.teamUid || e.teamId2 == team.teamUid;
    }).toList();
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
          backgroundColor: CustomColors.firebaseNavy,
          appBar: AppBar(
            centerTitle: true,
            title: Text('Team Profile'),
            // elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  FutureBuilder(
                  future: Provider.of<Teams>(context, listen: false)
                      .getImageUrl(team.teamUid),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return CircleAvatar(
                        radius: 80,
                        backgroundColor: CustomColors.primaryColor,
                        foregroundColor: Colors.white54,
                        backgroundImage: CachedNetworkImageProvider(
                          snapshot.data.toString(),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Icon(Icons.image_not_supported_sharp);
                    } else {
                      return CircleAvatar(
                        radius: 50,
                        backgroundColor: CustomColors.primaryColor,
                        foregroundColor: Colors.white54,
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      team.teamName,
                      
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.white30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Upcoming Matches',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  upcomingMatchList.isEmpty
                      ? Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              // color: Colors.white24,
                              ),
                          child: Center(
                            child: Text(
                              'No upcoming matches',
                              style: GoogleFonts.lato(
                                fontSize: 18,
                                color: Colors.white38,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        )
                      : Container(
                          // color: CustomColors.primaryColor.withAlpha(100),
                          margin: EdgeInsets.all(10),
                          height: 150,
                          child: ListView.builder(
                            itemCount: upcomingMatchList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) {
                              return UpcomingMatchCard(
                                match: upcomingMatchList[index],
                              );
                            },
                          ),
                        ),
                  Divider(
                    thickness: 1,
                    color: Colors.white30,
                  ),
                  Container(
                    // margin: const EdgeInsets.only(bottom: 20,top: 20),
                    child: Text(
                      'Players',
                      style: GoogleFonts.lato(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: players.length,
                      itemBuilder: (_, index) {
                        return PlayerCard(players[index]);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
  }
}
