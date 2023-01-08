import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fb;
import 'package:playerprofile/Dashboard/PlayerInformation/addPlayer.dart';
import 'package:playerprofile/Dashboard/PlayerInformation/personalInformation.dart';
class AllPlayers extends StatelessWidget {
  final clubId;
   AllPlayers({Key? key,this.clubId}) : super(key: key);
var colRef=fb.FirebaseFirestore.instance.collection("Players");
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
            Navigator.push(context, MaterialPageRoute(builder: (_)=>AddNewPlayer(clubId: clubId,)));

          }, icon: const Icon(Icons.add,color: Colors.white,))
        ],
      ),
      body: StreamBuilder(
          stream: colRef.where("Club Id",isEqualTo: clubId).snapshots(),
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
    );
  }
}
