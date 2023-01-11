import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:playerprofile/Authentication/spiner.dart';
import 'package:playerprofile/Dashboard/PlayerInformation/displayProfile.dart';

class AddNewPlayer extends StatefulWidget {
  final clubId;
  const AddNewPlayer({Key? key,this.clubId}) : super(key: key);

  @override
  State<AddNewPlayer> createState() => _AddNewPlayerState();
}

class _AddNewPlayerState extends State<AddNewPlayer> {
  bool edit=false;
  double height=0.0;
  double width=0.0;
  String? batsmen="Batsmen";
  String? bowler="Bowler";
  String? keeper="Keeper";
  String? allRounder="All Rounder";
  String? group="Batsmen";
  final _formKey =GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    return load?Spiner():Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Add Player"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.only(left: width*0.1,right:width*0.1 ),
          child: ListView(
            children: [
              SizedBox(height: 5,),
              Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(12),
                      shape: BoxShape.circle,
                      color: Colors.black,
                      border: Border.all(color: Colors.cyan,width: 3),
                      image: DecorationImage(
                          image:
                          image!=null?
                          Image.file(image!).image:
                          AssetImage('assets/images/logo.png',),fit: BoxFit.fill
                      )
                  ),
                  // child:image != null ?
                ),
              ),
              InkWell(
                splashColor:Colors.green,
                onTap:(){
                  showDialog(context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Choose Image',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)

                      ),
                      actions: <Widget>[
                        TextButton.icon(onPressed: camera,
                            icon: Icon(Icons.camera,color: Colors.grey,size: 30,),
                            label: Text('Camera',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
                        TextButton.icon(onPressed: gallery,
                            icon: Icon(Icons.image,color: Colors.grey,size: 30),
                            label: Text('Gallery',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)))

                      ],
                    ));},
                child: Icon(
                    Icons.add_a_photo,
                    size: 30,
                    color: Colors.grey),
              ),

              Center(
                child: Text('Add a Photo',
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,
                      fontSize: 12
                  ),),
              ),
              // Text("Name :"),
              ///Radio buttons
              Row(
                children: [
                  Radio<String>(
                      value:batsmen!,
                      groupValue:group,
                      onChanged: (val){
                        setState(() {
                          print(val);
                          group=val;
                        });
                      }),
                  Text("Batsmen"),
                  Radio<String>(
                      value:bowler!,
                      groupValue:group,
                      onChanged: (val){
                        setState(() {
                          group=val;
                        });

                      }),
                  Text("Bowler"),
                ],
              ),
              Row(
                children: [
                  Radio<String>(
                      value:keeper!,
                      groupValue:group,
                      onChanged: (val){
                        setState(() {
                          print(val);
                          group=val;
                        });
                      }),
                  Text("Keeper"),
                  Radio<String>(
                      value:allRounder!,
                      groupValue:group,
                      onChanged: (val){
                        setState(() {
                          group=val;
                        });

                      }),
                  Text("All Rounder"),
                ],
              ),
              //name
              SizedBox(
                height: height*0.1,

                child: TextFormField(
                    autovalidateMode:AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.name,
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Required"),
                      PatternValidator( ("[a-zA-Z $Spacer)]"),errorText: 'Only Characters')
                    ]),
                    onChanged: (val){
                      name=val;
                      },
                    style: const TextStyle(fontSize: 12),//password field
                    decoration:deco('Name')),
              ),
              //phone
              SizedBox(
                height: height*0.1,

                child: TextFormField(
                    autovalidateMode:AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Required"),
                      MaxLengthValidator(11, errorText: 'INVALID PHONE NUMBER'),
                      MinLengthValidator(11, errorText: 'INVALID PHONE NUMBER'),
                      PatternValidator( ("[0-9)]"),errorText: 'Only INTEGERS')
                    ]),
                    onChanged: (val){
                      phone=val;
                      },
                    style: const TextStyle(fontSize: 12),//password field
                    decoration:deco('Phone')),
              ),
              //age
              SizedBox(
                height: height*0.1,

                child: TextFormField(
                    autovalidateMode:AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Required"),
                      PatternValidator( ("[0-9)]"),errorText: 'Only INTEGERS')
                    ]),
                    onChanged: (val){
                     age=val;
                     },
                    style: const TextStyle(fontSize: 12),//password field
                    decoration:deco('Age')),
              ),
              //best for 3 types
              group=="Batsmen"?
              SizedBox(
                height: height*0.1,

                child: TextFormField(
                    autovalidateMode:AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Required"),
                      PatternValidator( ("[0-9)]"),errorText: 'Only INTEGERS')
                    ]),
                    onChanged: (val){
                      best=val;},
                    style: const TextStyle(fontSize: 12),//password field
                    decoration:deco('Best Score')),
              ):
              group=="Bowler"?
              SizedBox(
                height: height*0.1,

                child: TextFormField(
                    autovalidateMode:AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Required"),
                      PatternValidator( ("[0-9)]"),errorText: 'Only INTEGERS')
                    ]),
                    onChanged: (val){
                      best=val;},
                    style: const TextStyle(fontSize: 12),//password field
                    decoration:deco('Best Wickets')),
              ):
              ///for all rounder
              group=="All Rounder"?
              SizedBox(
                height: height*0.1,

                child: TextFormField(
                    autovalidateMode:AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Required"),
                      PatternValidator( ("[0-9)]"),errorText: 'Only INTEGERS')
                    ]),
                    onChanged: (val){
                      bestScore=val;},
                    style: const TextStyle(fontSize: 12),//password field
                    decoration:deco('Best Score')),
              ):Container(),
              group=="All Rounder"?
              SizedBox(
                height: height*0.1,

                child: TextFormField(
                    autovalidateMode:AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Required"),
                      PatternValidator( ("[0-9)]"),errorText: 'Only INTEGERS')
                    ]),
                    onChanged: (val){
                      bestWickets=val;},
                    style: const TextStyle(fontSize: 12),//password field
                    decoration:deco('Best Wickets')),
              ):Container(),



              //runs
              SizedBox(
                height: height*0.1,
                child: TextFormField(
                    autovalidateMode:AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Required"),
                      PatternValidator( ("[0-9)]"),errorText: 'Only INTEGERS')
                    ]),
                    onChanged: (val){
                      runs=val;},
                    style: const TextStyle(fontSize: 12),//password field
                    decoration:deco('Runs')),
              ),
             //total wickets
              group=="Bowler"?SizedBox(
                height: height*0.1,
                child: TextFormField(
                    autovalidateMode:AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Required"),
                      PatternValidator( ("[0-9)]"),errorText: 'Only INTEGERS')
                    ]),
                    onChanged: (val){
                      totalWickets=val;},
                    style: const TextStyle(fontSize: 12),//password field
                    decoration:deco('Total Wickets')),
              ):Container(),
              //total stumps
              group=="Keeper"?SizedBox(
                height: height*0.1,
                child: TextFormField(
                    autovalidateMode:AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Required"),
                      PatternValidator( ("[0-9)]"),errorText: 'Only INTEGERS')
                    ]),
                    onChanged: (val){
                      totalStumps=val;},
                    style: const TextStyle(fontSize: 12),//password field
                    decoration:deco('Total Stumps')),
              ):Container(),
              //50s
              SizedBox(
                height: height*0.1,
                child: TextFormField(
                    autovalidateMode:AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Required"),
                      PatternValidator( ("[0-9)]"),errorText: 'Only INTEGERS')
                    ]),
                    onChanged: (val){
                      fifty=val;
                      },
                    style: const TextStyle(fontSize: 12),//password field
                    decoration:deco('50s')),
              ),
              //100s
              SizedBox(
                height: height*0.1,
                child: TextFormField(
                    autovalidateMode:AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Required"),

                      PatternValidator( ("[0-9)]"),errorText: 'Only INTEGERS')
                    ]),
                    onChanged: (val){
                      century=val;},
                    style: const TextStyle(fontSize: 12),//password field
                    decoration:deco('100s')),
              ),
              //avg
              group=="Batsmen"?
              SizedBox(
                height: height*0.1,
                child: TextFormField(
                    autovalidateMode:AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Required"),
                      PatternValidator( ("[0-9)]"),errorText: 'Only INTEGERS')
                    ]),
                    onChanged: (val){
                      average=val;
                    },
                    style: const TextStyle(fontSize: 12),//password field
                    decoration:deco('Average Score')),
              ):
              group=="Bowler"?
              SizedBox(
                height: height*0.1,
                child: TextFormField(
                    autovalidateMode:AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Required"),
                      PatternValidator( ("[0-9)]"),errorText: 'Only INTEGERS')
                    ]),
                    onChanged: (val){
                      average=val;
                    },
                    style: const TextStyle(fontSize: 12),//password field
                    decoration:deco('Average Wickets')),
              ):
              group=="Keeper"?
              SizedBox(
                height: height*0.1,
                child: TextFormField(
                    autovalidateMode:AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Required"),
                      PatternValidator( ("[0-9)]"),errorText: 'Only INTEGERS')
                    ]),
                    onChanged: (val){
                      average=val;
                    },
                    style: const TextStyle(fontSize: 12),//password field
                    decoration:deco('Average Stumps')),
              ):Container(),
              ///for all rounder
              group=="All Rounder"?
              SizedBox(
                height: height*0.1,
                child: TextFormField(
                    autovalidateMode:AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Required"),
                      PatternValidator( ("[0-9)]"),errorText: 'Only INTEGERS')
                    ]),
                    onChanged: (val){
                      averageScore=val;
                    },
                    style: const TextStyle(fontSize: 12),//password field
                    decoration:deco('Average Score')),
              ):Container(),
              group=="All Rounder"?
              SizedBox(
                height: height*0.1,
                child: TextFormField(
                    autovalidateMode:AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Required"),
                      PatternValidator( ("[0-9)]"),errorText: 'Only INTEGERS')
                    ]),
                    onChanged: (val){
                      averageWickets=val;
                    },
                    style: const TextStyle(fontSize: 12),//password field
                    decoration:deco('Average Wickets')),
              ):Container(),

              //matches
              SizedBox(
                height: height*0.1,

                child: TextFormField(
                    autovalidateMode:AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Required"),
                      PatternValidator( ("[0-9)]"),errorText: 'Only INTEGERS')
                    ]),
                    onChanged: (val){
                      matches=val;
                      },
                    style: const TextStyle(fontSize: 12),//password field
                    decoration:deco('Matches')),
              ),
              Center(
                child: Text(errorText,style: TextStyle(color: Colors.red),),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: (){
                    if(_formKey.currentState!.validate()){
                        if(image!=null)
                        {
                     addPlayer();
                          }
                        else{
                          setState(() {
                            errorText="Please Upload a photo";
                          });
                        }
                    }
                  },
                  child:const  Text("Add"),
                ),
              ),
            ],
          ),
        ),
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
  Future gallery()async{
    Navigator.of(context).pop(true);
    var img= await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    // image=File(img.path);
    setState(() {
      image=File(img!.path);
    });
  }

  Future camera()async{
    Navigator.of(context).pop(true);
    // ignore: invalid_use_of_visible_for_testing_member
    var img= await ImagePicker.platform.pickImage(source: ImageSource.camera);

    setState(() {
      image=File(img!.path);
    });
  }
  File? image;
  String errorText="";

  Future<void> addPlayer() async {
    setState(() {
      load=true;
    });
    int random=DateTime.now().microsecond;
    var ref="$name$random";
    var imageRef= FirebaseStorage.instance.ref(ref);
    var task=await imageRef.putFile(image!);
    var imageUrl=await task.ref.getDownloadURL();
    if(group=="All Rounder"){
      await FirebaseFirestore.instance.collection("Players").add({
        "Image Url":imageUrl,
        "Club Id":widget.clubId,
        "Player Name":name,
        "Phone Number":phone,
        "Age":age,
        "Matches":matches,
        "Type":group,
        "century":century,
        "fifty":fifty,
        "Best Score":bestScore,
        "Best Wickets":bestWickets,
        "Runs":runs,
        "VideoUrl":"",
        "Average Score":averageScore,
        "Average Wickets":averageWickets,


      })
          .whenComplete(() => Navigator.pop(context));

    }else if(group=="Bowler") {
      await FirebaseFirestore.instance.collection("Players").add({
        "Image Url":imageUrl,
        "Club Id":widget.clubId,
        "Player Name":name,
        "Phone Number":phone,
        "Age":age,
        "Matches":matches,
        "Type":group,
        "century":century,
        "fifty":fifty,
        "Best":best,
        "Runs":runs,
        "VideoUrl":"",
        "Total Wickets":totalWickets,
        "Average":average,


      }).whenComplete(() => Navigator.pop(context));

    }else if(group=="Keeper") {
      await FirebaseFirestore.instance.collection("Players").add({
        "Image Url":imageUrl,
        "Club Id":widget.clubId,
        "Player Name":name,
        "Phone Number":phone,
        "Age":age,
        "Matches":matches,
        "Type":group,
        "century":century,
        "fifty":fifty,
        "VideoUrl":"",
        "Best":best,
        "Runs":runs,
        "Average":average,
        "Total Stumps":totalStumps,


      }).whenComplete(() => Navigator.pop(context));

    }else{
      await FirebaseFirestore.instance.collection("Players").add({
        "Image Url":imageUrl,
        "Club Id":widget.clubId,
        "Player Name":name,
        "Phone Number":phone,
        "Age":age,
        "Matches":matches,
        "VideoUrl":"",
        "Type":group,
        "century":century,
        "fifty":fifty,
        "Best":best,
        "Runs":runs,
        "Average":average,


      }).whenComplete(() => Navigator.pop(context));

    }
   }
  String name="";
  String phone="";
  String age="";
  String matches="";
  String century="";
  String fifty="";
  String best="";
  String bestScore="";
  String bestWickets="";

  String runs="";
  String totalWickets="";
  String totalStumps="";
  String average="";
  String averageScore="";
  String averageWickets="";
  String averageStumps="";
  bool load=false;
}
