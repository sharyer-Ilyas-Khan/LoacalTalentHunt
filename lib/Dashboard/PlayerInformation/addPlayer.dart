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
                    decoration:deco('Best')),
              ),
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
                    decoration:deco('Average')),
              ),
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
   await FirebaseFirestore.instance.collection("Players").add({
      "Image Url":imageUrl,
      "Club Id":widget.clubId,
      "Player Name":name,
      "Phone Number":phone,
      "Age":age,
      "Matches":matches,
      "century":century,
      "fifty":fifty,
      "Best":best,
      "Runs":runs,
      "Average":average,


    }).whenComplete(() => Navigator.pop(context));
  }
  String name="";
  String phone="";
  String age="";
  String matches="";
  String century="";
  String fifty="";
  String best="";
  String runs="";
  String average="";
  bool load=false;
}
