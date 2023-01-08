import 'package:flutter/material.dart';
import 'package:playerprofile/Dashboard/PlayerInformation/listofplayers.dart';
import 'package:playerprofile/SimpleUser/dashboard/drawer.dart';
import 'package:playerprofile/SimpleUser/players/allPlayerVisitor.dart';

import '../clubs/allClubs.dart';
import '../allTournament.dart';
class UserDashboard extends StatefulWidget {
  const UserDashboard({Key? key}) : super(key: key);

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> with TickerProviderStateMixin{
  late TabController _tabController;
  double height=0.0;
  double width=0.0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.animateTo(0);
  }

  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    return Scaffold(
  drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Visitor"),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,

          tabs: [
            Tab(
                child: Text("Clubs",style:textStyle(0.016, Colors.white))),
            Tab(
              child: Text("Players",style:textStyle(0.016, Colors.white)),),
            Tab(
              child: Text("Tournaments",style:textStyle(0.016, Colors.white)),),
          ],
        ),
      ),
      body:TabBarView(
        controller: _tabController,
        children: [
          AllClubs(),
          AllPlayersVisitors(),
         AllTournaments()
        ],
      )
    );
  }
  TextStyle textStyle(font,color){
    return TextStyle(
        fontSize: height*font,
        color: color
    );
  }
}
