import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:playerprofile/Authentication/user.dart';
import 'package:playerprofile/Dashboard/ClubInformation/clubsHome.dart';
import 'package:playerprofile/Dashboard/MatchesInformation/matchHome.dart';
import 'package:playerprofile/Dashboard/PlayerInformation/listofplayers.dart';
import 'package:playerprofile/Dashboard/PlayerInformation/personalInformation.dart';
import 'package:playerprofile/Dashboard/TournamentsInformation/tournametHome.dart';
import 'package:playerprofile/Dashboard/Trophies/trophiesHome.dart';

import 'package:playerprofile/Dashboard/MainScreens/drawer.dart';
import 'package:provider/provider.dart';

import '../ClubInformation/displayInfo.dart';
class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late User? user;
  @override
  Widget build(BuildContext context) {
    user=Provider.of<User?>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Dashboard"
        ),
        elevation: 20,
        shadowColor: Colors.blue,
      ),
      drawer: CustomDrawer(),
      body: Column(
        children: [
            Expanded(child:  DisplayClubInfoData()),
          Expanded(
              flex: 3,
              child: Column(
                children:  [
                  optionCard("Clubs Information", "View/Member","stadium", ClubsHome(clubId: user!.uid,)),
                  optionCard("Players Information", "View/Edit Bio","player", AllPlayers(clubId:user!.uid ,)),
                  optionCard("Matches Information", "View/Add Matches","cricket", MatchesHome(clubId:user!.uid)),
                  optionCard("Tournaments", "View/Add ","stump", TournamentHome(clubId:user!.uid)),
                  optionCard("Trophies", "winning","trophy", TrophiesHome(clubId:user!.uid )),

                ],
              )
          )
        ],
      ),
    );
  }
  Widget optionCard(title,subTitle,image,route){
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (_)=>route));
      },
      child:  Padding(
        padding: const EdgeInsets.only(left: 12.0,right: 12.0,top: 12.0),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(60.0),
                bottomLeft: Radius.circular(40.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.blue,
                blurRadius: 4,
                spreadRadius: 1,

              )
            ]

          ),
          child: ListTile(

            leading: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                image: DecorationImage(

                  image: AssetImage("assets/images/$image.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            title: Text(title),
            subtitle: Text(subTitle,style:  TextStyle(color: Colors.black.withOpacity(0.3)),),
          ),
        ),
      ),
    );
  }
}
