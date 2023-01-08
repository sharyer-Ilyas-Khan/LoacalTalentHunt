import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


import '../../Dashboard/ClubInformation/displayInfo.dart';
import '../players/playerInfo.dart';
class ClubInfo extends StatefulWidget {
  final clubId;
  const ClubInfo({Key? key,this.clubId}) : super(key: key);

  @override
  State<ClubInfo> createState() => _ClubInfoState();
}

class _ClubInfoState extends State<ClubInfo> {
  double height=0.0;
  double width=0.0;
  var colRef=FirebaseFirestore.instance.collection("Players");
  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Club Information"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(

              height: height*0.3,
              width: width,
              decoration: BoxDecoration(
                  color: Colors.amber
              ),
              child: CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 1.999,
                  autoPlay: true,
                  viewportFraction: 0.9,
                  // enlargeCenterPage: true,

                ),

                items: [
                  Image(image: AssetImage("assets/images/cricket.png"),fit: BoxFit.fill,),
                  Image(image: AssetImage("assets/images/helmet.png"),fit: BoxFit.fill,),
                  Image(image: AssetImage("assets/images/stadium.png"),fit: BoxFit.fill,),
                  Image(image: AssetImage("assets/images/trophy.png"),fit: BoxFit.fill,),
                ],
              ),
            ),
          ),
          SizedBox(
            height: height*0.2,
            child: Padding(
              padding:  EdgeInsets.all(8.0),
              child: DisplayClubInfoData(),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("All Players:"),
          ),
          Center(
            child: Container(

              height: height*0.3,
              width: width*0.9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: Colors.black12)
              ),
              child:StreamBuilder(
                  stream: colRef.where("Club Id",isEqualTo: widget.clubId).snapshots(),
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


                  })
            ),
          ),
        ],
      ),
    );
  }
}
