import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:playerprofile/SimpleUser/players/playerInfo.dart';



class AllPlayersVisitors extends StatefulWidget {
  const AllPlayersVisitors({Key? key}) : super(key: key);

  @override
  State<AllPlayersVisitors> createState() => _AllPlayersVisitorsState();
}

class _AllPlayersVisitorsState extends State<AllPlayersVisitors>with TickerProviderStateMixin {
  var colRef=FirebaseFirestore.instance.collection("Players");
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
        elevation: 20,
        shadowColor: Colors.blue,
        title: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
                child: Text("Batsmen",style:textStyle(0.014, Colors.white))),
            Tab(
              child: Text("Bowler",style:textStyle(0.014, Colors.white)),),
            Tab(
              child: Text("Keeper",style:textStyle(0.014, Colors.white)),),
            Tab(
              child: Text("All Rounder",style:textStyle(0.014, Colors.white)),),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          StreamBuilder(
              stream: colRef

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
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>PlayerInfo(data:snap.data!.docs[index])));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.black,
                                backgroundImage: NetworkImage(snap.data!.docs[index].get("Image Url")),
                              ),
                              trailing: index<3?Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage("assets/images/top.jpg"),
                                    )
                                ),
                              ):Container( height: 40,
                                width: 40,),
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
          StreamBuilder(
              stream: colRef
                  .where("Type",isEqualTo: "Bowler")
                  .orderBy("Average",descending: true)
                  .
              snapshots(),
              builder: (_,snap){
                if(snap.data!=null && snap.data!.docs.isNotEmpty){
                  return ListView.builder(
                      itemCount:snap.data!.docs.length ,
                      itemBuilder: (_,index){
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>PlayerInfo(data:snap.data!.docs[index])));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.black,
                                backgroundImage: NetworkImage(snap.data!.docs[index].get("Image Url")),
                              ),
                              trailing: index<3?Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage("assets/images/top.jpg"),
                                    )
                                ),
                              ):Container( height: 40,
                                width: 40,),
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
          StreamBuilder(
              stream: colRef
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
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>PlayerInfo(data:snap.data!.docs[index])));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.black,
                                backgroundImage: NetworkImage(snap.data!.docs[index].get("Image Url")),
                              ),
                              trailing: index<3?Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage("assets/images/top.jpg"),
                                    )
                                ),
                              ):Container( height: 40,
                                width: 40,),
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
          StreamBuilder(
              stream: colRef
                  .where("Type",isEqualTo: "All Rounder")
                  // .orderBy("Average",descending: true)
                  .snapshots(),
              builder: (_,snap){
                if(snap.data!=null && snap.data!.docs.isNotEmpty){
                  return ListView.builder(
                      itemCount:snap.data!.docs.length ,
                      itemBuilder: (_,index){
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>PlayerInfo(data:snap.data!.docs[index])));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.black,
                                backgroundImage: NetworkImage(snap.data!.docs[index].get("Image Url")),
                              ),
                              trailing: index<3?Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage("assets/images/top.jpg"),
                                    )
                                ),
                              ):Container( height: 40,
                                width: 40,),
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
        ],

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