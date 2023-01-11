import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:playerprofile/Dashboard/TournamentsInformation/tournamentDetails.dart';


class AllTournaments extends StatefulWidget {
  const AllTournaments({Key? key}) : super(key: key);

  @override
  State<AllTournaments> createState() => _AllTournamentsState();
}

class _AllTournamentsState extends State<AllTournaments> {
  var colRef=FirebaseFirestore.instance.collection("Tournaments");
  double height=0.0;
  double width=0.0;

  @override

  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
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
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>
                            Details(data: snap.data!.docs[index],type:'',clubId:snap.data!.docs[index].get("Club Id"),)));

                      },
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: height*0.2,
                            width: width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 1,
                                    spreadRadius: 1,
                                  )
                                ]
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 30,
                                      color: Colors.blue.shade200,
                                      child: Center(
                                        child: Text(snap.data!.docs[index].get("Tournament Name")),
                                      ),
                                    ),
                                    Text("Wining Price:\t\t${snap.data!.docs[index].get("Wining Price")}",style:detail(0.018) ,),
                                    Text("Entry Fee:\t\t${snap.data!.docs[index].get("Entry Fee")}",style:detail(0.018)),
                                    Text("Start Date:\t\t${snap.data!.docs[index].get("Start Date")}",style:detail(0.018)),
                                    Align(alignment:Alignment.bottomRight,child: Text("tap for more >",style:detail(0.013)))
                                  ],
                                ),
                              ),
                            ),
                          )
                      ),
                    );
                  });
            }
            else{
              return const Center(
                child: Text("No Tournament Found"),
              );
            }


          }),
    );
  }
  TextStyle detail(font){
    return TextStyle(
      fontSize: height*font,
    );
  }
}