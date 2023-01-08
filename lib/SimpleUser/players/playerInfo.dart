import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../Dashboard/PlayerInformation/displayProfile.dart';


class PlayerInfo extends StatefulWidget {
  final data;
  const PlayerInfo({Key? key,this.data}) : super(key: key);

  @override
  State<PlayerInfo> createState() => _PlayerInfoState();
}

class _PlayerInfoState extends State<PlayerInfo> {
  double height=0.0;
  double width=0.0;
  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Player Profile"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Center(
           child: Container(

             height: height*0.3,
             width: width,
             decoration: const BoxDecoration(
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
             child:  DisplayPlayerInfoData(data:widget.data),
           ),
         ),

         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Text("Joined Club:"),
         ),
         Center(
           child: Container(

             height: height*0.15,
             width: width*0.9,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(15.0),
               border: Border.all(color: Colors.black12)
             ),
             child: StreamBuilder(
                 stream: FirebaseFirestore.instance.collection("clubs").snapshots(),
                 builder: (_,snap){
                   var id=widget.data.get("Club Id");

                   if(snap.data!=null && snap.data!.docs.isNotEmpty){
                     return ListView.builder(
                         itemCount:snap.data!.docs.length ,
                         itemBuilder: (_,index){
                           if(id==snap.data!.docs[index].id){
                             return Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: InkWell(
                                 onTap: (){
                                   // Navigator.push(context, MaterialPageRoute(builder: (_)=>PlayerPersonalInformation(data:snap.data!.docs[index])));
                                 },
                                 child: ListTile(
                                   leading: CircleAvatar(
                                     radius: 25,
                                     backgroundColor: Colors.black,
                                     backgroundImage: NetworkImage(snap.data!.docs[index].get("ImageUrl")),
                                   ),
                                   title: Text(snap.data!.docs[index].get("Club Name")),

                                   subtitle: Text("${snap.data!.docs[index].get("Phone Number")}"),
                                 ),
                               ),
                             );
                           }
                           else{
                             return Container();
                           }

                         });
                   }
                   else{
                     return const Center(
                       child: Text("No Club Found"),
                     );
                   }


                 }),
           ),
         ),
       ],
      ),
    );
  }
}
