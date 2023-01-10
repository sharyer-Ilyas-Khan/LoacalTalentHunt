import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:playerprofile/SimpleUser/players/playerInfo.dart';



class AllPlayersVisitors extends StatefulWidget {
  const AllPlayersVisitors({Key? key}) : super(key: key);

  @override
  State<AllPlayersVisitors> createState() => _AllPlayersVisitorsState();
}

class _AllPlayersVisitorsState extends State<AllPlayersVisitors> {
  var colRef=FirebaseFirestore.instance.collection("Players");
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Players"
        ),
        elevation: 20,
        shadowColor: Colors.blue,
      ),
      body: StreamBuilder(
          stream: colRef.orderBy("Average",descending: true).snapshots(),
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
    );
  }
}