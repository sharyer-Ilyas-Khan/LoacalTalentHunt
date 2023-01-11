import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:playerprofile/Dashboard/ClubInformation/clubController.dart';
import 'package:provider/provider.dart';

import '../../videoPlayer.dart';
import 'displayInfo.dart';


class ClubsHome extends StatefulWidget {
  final clubId;
  const ClubsHome({Key? key,this.clubId}) : super(key: key);

  @override
  State<ClubsHome> createState() => _ClubsHomeState();
}

class _ClubsHomeState extends State<ClubsHome> {
  bool edit=false;
  double height=0.0;
  double width=0.0;
  late ClubData clubData;
  CollectionReference clubCol=FirebaseFirestore.instance.collection('clubs');
  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    clubData=Provider.of<ClubData>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Club Information"),
      ),
      body: Column(
        children: [
          Expanded(
            child:  Padding(
              padding:  EdgeInsets.all(8.0),
              child:  DisplayClubInfoData(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              SizedBox(width: 10,),
              Center(
                child: ElevatedButton(
                  onPressed: (){
                    gallery();
                  },
                  child:const  Text("Add Video"),
                ),
              ),
            ],
          ),
          Expanded(
              flex:2,
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
                            Text("Phone :"),
                            Text("Area :"),
                            Text("Address:"),

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
                                    phone=val;
                                    },
                                  style: const TextStyle(fontSize: 12),//password field
                                  decoration:deco('Phone')),
                            ),
                            SizedBox(
                              height: height*0.055,
                              width: height*0.35,
                              child: TextFormField(

                                  onChanged: (val){
                                    area=val;},
                                  style: const TextStyle(fontSize: 12),//password field
                                  decoration:deco('Area')),
                            ),
                            SizedBox(
                              height: height*0.055,
                              width: height*0.35,
                              child: TextFormField(

                                  onChanged: (val){
                                   address=val;
                                    },
                                  style: const TextStyle(fontSize: 12),//password field
                                  decoration:deco('Address')),
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
              )),
          // edit?Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     InkWell(
          //       child: Container(
          //         height: 40,
          //         width: width*0.6,
          //         decoration: BoxDecoration(
          //
          //             borderRadius: BorderRadius.circular(15.0),
          //             border: Border.all(style: BorderStyle.solid,color: Colors.black26)
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
              updateClubInfo();
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
  Future<void> updateClubInfo() async {

    await clubCol.doc(widget.clubId).set({
      'Club Name': clubData.name,
      'Email': clubData.email,
      'ImageUrl': clubData.image,
      'Password': clubData.pass,
      'Phone Number': phone??"${clubData.phone}",
      'Type':clubData.type,
      'Address':address??"${clubData.address}",
      'Area':area??"${clubData.area}",
    }).whenComplete(() => setState((){edit=false;}));
  }
  String? phone;
  String? address;
  String? area;
  Future gallery()async{
    var vido= await ImagePicker.platform.pickVideo(source: ImageSource.gallery);
    if(vido!=null){
      setState(() {
        video=File(vido.path);
      });
      Navigator.push(context,MaterialPageRoute(builder: (_)=>VideoPlayersForUpload(
        file: video,id: widget.clubId,
        type:"club"
      )));

    }
  }

  File? video;
}
