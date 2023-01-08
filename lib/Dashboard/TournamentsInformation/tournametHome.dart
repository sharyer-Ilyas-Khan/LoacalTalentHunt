import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'addtournament.dart';
import 'myTournaments.dart';
import 'othertournaments.dart';
class TournamentHome extends StatefulWidget {
  final clubId;
  const TournamentHome({Key? key,this.clubId}) : super(key: key);

  @override
  State<TournamentHome> createState() => _TournamentHomeState();
}

class _TournamentHomeState extends State<TournamentHome> with TickerProviderStateMixin {
  var colRef=FirebaseFirestore.instance.collection("Tournaments");
  double height=0.0;
  double width=0.0;
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.animateTo(0);
  }
  @override

  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Tournaments"),
        bottom: TabBar(
          controller: _tabController,

          tabs: [
            Tab(
                child: Text("Created",style:textStyle(0.02, Colors.white))),
            Tab(
              child: Text("Others",style:textStyle(0.02, Colors.white)),),
          ],
        ),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (_)=>AddTournament(clubId: widget.clubId,)));
          }, icon: Icon(Icons.add,color: Colors.white,))
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
         MyTournaments(clubId:widget.clubId),
          OtherTournaments(clubId:widget.clubId)
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
