import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:playerprofile/Dashboard/PlayerInformation/displayProfile.dart';
import 'package:playerprofile/Dashboard/PlayerInformation/playerController.dart';
import 'package:provider/provider.dart';

class PlayerPersonalInformation extends StatefulWidget {
  final data;
  const PlayerPersonalInformation({Key? key,this.data}) : super(key: key);

  @override
  State<PlayerPersonalInformation> createState() => _PlayerPersonalInformationState();
}

class _PlayerPersonalInformationState extends State<PlayerPersonalInformation> {
  bool edit=false;
  double height=0.0;
  double width=0.0;
 late  PlayerData playerData;
  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    playerData=Provider.of<PlayerData>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Player Profile"),
        actions: [
         IconButton(onPressed: (){
            showDialog(context: context, builder: (_)=>AlertDialog(
              title: Text("Are you sure you want to delete this tournament."),
              actions: [
                TextButton(onPressed: (){
                  removePlayer();
                }, child: Text("Yes")),
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text("No")),

              ],
            ));

          }, icon: const Icon(Icons.delete,color: Colors.white,))
        ],
      ),
      body: ListView(
        children: [
           SizedBox(
             height: height*0.2,
             child: Padding(
               padding:  EdgeInsets.all(8.0),
               child:  DisplayPlayerInfoData(data:widget.data),
             ),
           ),
          edit?Center(
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red)
              ),
              onPressed: (){
              setState(() {
                edit=false;
              });
              },
              child:const  Text("Cancel"),
            ),
          ):Center(
            child: ElevatedButton(
              onPressed: (){
                setState(() {
                  edit=true;
                });
              },
              child:const  Text("  Edit  "),
            ),
          ),
          SizedBox(
            height: height*0.8,
            child: Stack(
             children: [
               Padding(
             padding: const EdgeInsets.all(15.0),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: const [
                     Text("AGE :"),
                     Text("Best :"),
                     Text("Runs :"),
                     Text("Phone :"),
                     Text("50s :"),
                     Text("100s :"),
                     Text("Average :"),
                     Text("Matches:"),

                   ],
                 ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     SizedBox(
                       height: height*0.055,
                       width: height*0.35,
                       child: TextFormField(

                           onChanged: (val){
                             age=val;

                             },
                           style: const TextStyle(fontSize: 12),//password field
                           decoration:deco('Age')),
                     ),
                     SizedBox(
                       height: height*0.055,
                       width: height*0.35,
                       child: TextFormField(

                           onChanged: (val){
                             best=val;},
                           style: const TextStyle(fontSize: 12),//password field
                           decoration:deco('Best')),
                     ),
                     SizedBox(
                       height: height*0.055,
                       width: height*0.35,
                       child: TextFormField(

                           onChanged: (val){
                             runs=val;},
                           style: const TextStyle(fontSize: 12),//password field
                           decoration:deco('Runs')),
                     ),
                     SizedBox(
                       height: height*0.055,
                       width: height*0.35,
                       child: TextFormField(

                           onChanged: (val){
                             phone=val;},
                           style: const TextStyle(fontSize: 12),//password field
                           decoration:deco('Phone')),
                     ),
                     SizedBox(
                       height: height*0.055,
                       width: height*0.35,
                       child: TextFormField(

                           onChanged: (val){
                             fifty=val;},
                           style: const TextStyle(fontSize: 12),//password field
                           decoration:deco('50s')),
                     ),
                     SizedBox(
                       height: height*0.055,
                       width: height*0.35,
                       child: TextFormField(

                           onChanged: (val){
                             century=val;},
                           style: const TextStyle(fontSize: 12),//password field
                           decoration:deco('100s')),
                     ),
                     SizedBox(
                       height: height*0.055,
                       width: height*0.35,
                       child: TextFormField(

                           onChanged: (val){
                             average=val;
                             },
                           style: const TextStyle(fontSize: 12),//password field
                           decoration:deco('Average')),
                     ),
                     SizedBox(
                       height: height*0.055,
                       width: height*0.35,
                       child: TextFormField(

                           onChanged: (val){
                             matches=val;
                             },
                           style: const TextStyle(fontSize: 12),//password field
                           decoration:deco('Matches')),
                     ),






                   ],
                 ),
               ],
             ),
               ),
               edit?Container():
               Container(
             color: Colors.black12,
               )
             ],
            ),
          ),
          // edit?Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     InkWell(
          //       child: Container(
          //         height: 40,
          //         width: width*0.6,
          //         decoration: BoxDecoration(
          //
          //           borderRadius: BorderRadius.circular(15.0),
          //           border: Border.all(style: BorderStyle.solid,color: Colors.black26)
          //         ),
          //         child:  Center(
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: const [
          //               Text("Upload Image",style: TextStyle(color: Colors.black54),),
          //               Padding(
          //                 padding:  EdgeInsets.all(8.0),
          //                 child: Icon(Icons.cloud_upload_sharp,color: Colors.black54,),
          //               )
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //     Center(
          //       child: ElevatedButton(
          //         onPressed: (){
          //
          //         },
          //         child:const  Text("Update"),
          //       ),
          //     ),
          //   ],
          // ):Container(),
          edit?Center(
            child: ElevatedButton(
              onPressed: (){
                  updateData();
              },
              child:const  Text("Update"),
            ),
          ):Container(),
        ],
      ),
    );
  }
  InputDecoration deco(String text){
    return InputDecoration(
      labelText: '$text',
      border:OutlineInputBorder(
          borderRadius:BorderRadius.circular(12),
          borderSide:BorderSide(color: Colors.black,
              width: 2) ),


    );
  }
  Future<void> updateData() async {
    await FirebaseFirestore.instance.collection("Players").doc(widget.data.id).set({
      "Image Url":playerData.image,
      "Club Id":playerData.clubId,
      "Player Name":playerData.name,
      "Phone Number":phone??playerData.phone,
      "Age":age??playerData.age,
      "Matches":matches??playerData.matches,
      "century":century??playerData.century,
      "fifty":fifty??playerData.fifty,
      "Best":best??playerData.best,
      "Runs":runs??playerData.runs,
      "Average":average??playerData.average,


    }).whenComplete(() => Navigator.pop(context));

  }
  String? phone;
  String? age;
  String? matches;
  String? century;
  String? fifty;
  String? best;
  String? runs;
  String? average;
  Future<void> removePlayer() async {

    await FirebaseFirestore.instance.collection("Players").doc(widget.data.id).delete().whenComplete(() {
      Navigator.pop(context); Navigator.pop(context);});
  }
}
