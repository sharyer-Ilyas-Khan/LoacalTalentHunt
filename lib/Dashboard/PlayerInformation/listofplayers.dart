import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fb;
import 'package:playerprofile/Dashboard/PlayerInformation/addPlayer.dart';
import 'package:playerprofile/Dashboard/PlayerInformation/personalInformation.dart';
class AllPlayers extends StatefulWidget {
  final clubId;
   AllPlayers({Key? key,this.clubId}) : super(key: key);

  @override
  State<AllPlayers> createState() => _AllPlayersState();
}

class _AllPlayersState extends State<AllPlayers> with TickerProviderStateMixin  {
var colRef=fb.FirebaseFirestore.instance.collection("Players");
late TabController _tabController;
@override
void initState() {
  super.initState();
  _tabController = TabController(length: 4, vsync: this);
  _tabController.animateTo(0);
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Players"
        ),
        elevation: 20,
        shadowColor: Colors.blue,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (_)=>AddNewPlayer(clubId: widget.clubId,)));

          }, icon: const Icon(Icons.add,color: Colors.white,))
        ],
        bottom: TabBar(
          controller: _tabController,

          tabs: [
            Tab(
                child: Text("Batsmen",style:textStyle(0.016, Colors.white))),
            Tab(
              child: Text("Bowler",style:textStyle(0.016, Colors.white)),),
            Tab(
              child: Text("Keeper",style:textStyle(0.016, Colors.white)),),
            Tab(
              child: Text("All Rounder",style:textStyle(0.016, Colors.white)),),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children:[
          ///batsmen
          StreamBuilder(
              stream: colRef.where("Club Id",isEqualTo: widget.clubId)
                  .where("Type",isEqualTo: "Batsmen")
                  .orderBy("Average",descending: true)
                  .snapshots(),
              builder: (_,snap){
                if(snap.data!=null && snap.data!.docs.isNotEmpty){
                  return ListView.builder(
                      itemCount:snap.data!.docs.length ,
                      itemBuilder: (_,index){
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>PlayerPersonalInformation(data:snap.data!.docs[index],)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              trailing: index<3?Container(
                                height: 40,
                                width: 40,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage("assets/images/top.jpg"),
                                    )
                                ),
                              ):Container( height: 40,
                                width: 40,),
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.black,
                                backgroundImage: NetworkImage(snap.data!.docs[index].get("Image Url")),
                              ),
                              title: Text(snap.data!.docs[index].get("Player Name")),
                              subtitle: Text("${snap.data!.docs[index].get("Phone Number")}\n tap for more..."),
                            ),
                          ),
                        );
                      });
                }
                else{
                  return const Center(
                    child: Text("No Player Found"),
                  );
                }


              }),
          ///Bowler
          StreamBuilder(
              stream: colRef.where("Club Id",isEqualTo: widget.clubId)
                  .where("Type",isEqualTo: "Bowler")
                  .orderBy("Average",descending: true)
                  .snapshots(),
              builder: (_,snap){
                if(snap.data!=null && snap.data!.docs.isNotEmpty){
                  return ListView.builder(
                      itemCount:snap.data!.docs.length ,
                      itemBuilder: (_,index){
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>PlayerPersonalInformation(data:snap.data!.docs[index],)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              trailing: index<3?Container(
                                height: 40,
                                width: 40,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage("assets/images/top.jpg"),
                                    )
                                ),
                              ):Container( height: 40,
                                width: 40,),
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.black,
                                backgroundImage: NetworkImage(snap.data!.docs[index].get("Image Url")),
                              ),
                              title: Text(snap.data!.docs[index].get("Player Name")),
                              subtitle: Text("${snap.data!.docs[index].get("Phone Number")}\n tap for more..."),
                            ),
                          ),
                        );
                      });
                }
                else{
                  return const Center(
                    child: Text("No Player Found"),
                  );
                }


              }),
          ///Keeper
          StreamBuilder(
              stream: colRef.where("Club Id",isEqualTo: widget.clubId)
                  .where("Type",isEqualTo: "Keeper")
                  .orderBy("Average",descending: true)
                  .snapshots(),
              builder: (_,snap){
                if(snap.data!=null && snap.data!.docs.isNotEmpty){
                  return ListView.builder(
                      itemCount:snap.data!.docs.length ,
                      itemBuilder: (_,index){
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>PlayerPersonalInformation(data:snap.data!.docs[index],)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              trailing: index<3?Container(
                                height: 40,
                                width: 40,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage("assets/images/top.jpg"),
                                    )
                                ),
                              ):Container( height: 40,
                                width: 40,),
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.black,
                                backgroundImage: NetworkImage(snap.data!.docs[index].get("Image Url")),
                              ),
                              title: Text(snap.data!.docs[index].get("Player Name")),
                              subtitle: Text("${snap.data!.docs[index].get("Phone Number")}\n tap for more..."),
                            ),
                          ),
                        );
                      });
                }
                else{
                  return const Center(
                    child: Text("No Player Found"),
                  );
                }


              }),
          ///All rounder
          StreamBuilder(
              stream: colRef.where("Club Id",isEqualTo: widget.clubId).where("Type",isEqualTo: "All Rounder").snapshots(),
              builder: (_,snap){
                if(snap.data!=null && snap.data!.docs.isNotEmpty){
                  return ListView.builder(
                      itemCount:snap.data!.docs.length ,
                      itemBuilder: (_,index){
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>PlayerPersonalInformation(data:snap.data!.docs[index],)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              // trailing: index<3?Container(
                              //   height: 40,
                              //   width: 40,
                              //   decoration: const BoxDecoration(
                              //       shape: BoxShape.circle,
                              //       image: DecorationImage(
                              //         image: AssetImage("assets/images/top.jpg"),
                              //       )
                              //   ),
                              // ):Container( height: 40,
                              //   width: 40,),
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.black,
                                backgroundImage: NetworkImage(snap.data!.docs[index].get("Image Url")),
                              ),
                              title: Text(snap.data!.docs[index].get("Player Name")),
                              subtitle: Text("${snap.data!.docs[index].get("Phone Number")}\n tap for more..."),
                            ),
                          ),
                        );
                      });
                }
                else{
                  return const Center(
                    child: Text("No Player Found"),
                  );
                }


              }),

        ]

      ),
    );
  }

  TextStyle textStyle(font,color){
    return TextStyle(
        fontSize: MediaQuery.of(context).size.height*font,
        color: color
    );
  }
}
