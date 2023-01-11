import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:playerprofile/Dashboard/ClubInformation/clubsHome.dart';


import 'clubinfo.dart';

class AllClubs extends StatefulWidget {
  const AllClubs({Key? key}) : super(key: key);

  @override
  State<AllClubs> createState() => _AllClubsState();
}

class _AllClubsState extends State<AllClubs> {
  var colRef=FirebaseFirestore.instance.collection("clubs");
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: StreamBuilder(
          stream: colRef.snapshots(),
          builder: (_,snap){
            if(snap.data!=null && snap.data!.docs.isNotEmpty){
              return ListView.builder(
                  itemCount:snap.data!.docs.length ,
                  itemBuilder: (_,index){
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>ClubInfo(clubId:snap.data!.docs[index].id,VideoUrl:snap.data!.docs[index].get("VideoUrl"))));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.black,
                            backgroundImage: NetworkImage(snap.data!.docs[index].get("ImageUrl")),
                          ),
                          title: Text(snap.data!.docs[index].get("Club Name")),

                          subtitle: Text("${snap.data!.docs[index].get("Phone Number")}\n tap for more..."),
                        ),
                      ),
                    );
                  });
            }
            else{
              return const Center(
                child: Text("No Club Found"),
              );
            }


          }),
    );
  }
}
