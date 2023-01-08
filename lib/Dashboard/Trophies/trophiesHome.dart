
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'addTrophy.dart';
import 'package:playerprofile/Dashboard/Trophies/trophyController.dart';
import 'package:provider/provider.dart';

class TrophiesHome extends StatefulWidget {
  final clubId;
  const TrophiesHome({Key? key,this.clubId}) : super(key: key);

  @override
  State<TrophiesHome> createState() => _TrophiesHomeState();
}

class _TrophiesHomeState extends State<TrophiesHome> {
  double height=0.0;
  double width=0.0;
  var colRef=FirebaseFirestore.instance.collection("Trophies");
  late TrophyData trophyData;
  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    trophyData=Provider.of<TrophyData>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Trophies"),
        actions: [
          IconButton(onPressed: (){
          trophyData.add(true);
            }, icon:
          const Icon(Icons.add,color: Colors.white,))
        ],
      ),
      body: Stack(
        children: [
          trophyData.isLoad?
          Center(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
                SizedBox(
                  height:20
                ),
                Text("Adding Trophy")
              ],
            )
          ):StreamBuilder(
              stream: colRef.where("Club Id",isEqualTo: widget.clubId).snapshots(),
              builder: (_,snap){
                if(snap.data!=null && snap.data!.docs.isNotEmpty){
                  return ListView.builder(
                      itemCount:snap.data!.docs.length ,
                      itemBuilder: (_,index){
                        return  ListTile(
                          leading: CircleAvatar(
                            radius:30,
                            backgroundColor: Colors.black,
                            backgroundImage:  NetworkImage(snap.data!.docs[index].get("Image Url")),
                            // foregroundImage: AssetImage("assets/images/logo.png"),
                          ),
                          title: Text(snap.data!.docs[index].get("Name")),
                          subtitle: Text(snap.data!.docs[index].get("Match")),
                        );
                      });
                }
                else{
                  return  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(),
                        SizedBox(height:20),
                        Text("No Trophy Found"),
                      ],
                    ),
                  );
                }


              }),
          trophyData.adding?AddTrophy(clubId: widget.clubId,):Container()
        ],
      ),
    );
  }


}
