import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:playerprofile/Dashboard/Trophies/trophyController.dart';
import 'package:provider/provider.dart';
class AddTrophy extends StatelessWidget {
  final clubId;
   AddTrophy({Key? key,this.clubId}) : super(key: key);

  double height=0.0;
  double width=0.0;
  late TrophyData trophyData;
  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    trophyData=Provider.of<TrophyData>(context);
    return Container(
      height: height,
      width: width,
      color: Colors.black54,
      child: Center(
        child: Container(
          color: Colors.white70,
          child: SizedBox(
            height: height*0.5,
            width: width*0.9,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:  [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon:Icon(Icons.cancel),
                        onPressed: (){
                          trophyData.add(false);
                          trophyData.error("");
                        },
                      ),
                    ),
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
                                image:trophyData.image!=null?
                                Image.file(trophyData.image!).image:
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
                                TextButton.icon(onPressed: (){camera(context);},
                                    icon: Icon(Icons.camera,color: Colors.grey,size: 30,),
                                    label: Text('Camera',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
                                TextButton.icon(onPressed: (){gallery(context);},
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
                    SizedBox(
                      height: height*0.055,
                      width: width*0.8,
                      child: TextFormField(

                          onChanged: (val){
                            name=val;
                          },
                          style: const TextStyle(fontSize: 12),//password field
                          decoration:deco('Name')),
                    ),
                    SizedBox(
                      height: height*0.01,
                    ),
                    SizedBox(
                      height: height*0.055,
                      width: width*0.8,
                      child: TextFormField(

                          onChanged: (val){
                            match=val;
                          },
                          style: const TextStyle(fontSize: 12),//password field
                          decoration:deco('Name of Match')),
                    ),
                    Text(trophyData.errorText,style:TextStyle(color: Colors.red)),
                    ElevatedButton(onPressed: (){
                      if(name!="" && match!="" && trophyData.image!=null){
                        addTrophy(context);
                      }
                      else{
                        trophyData.error("one or more attribute is missing");
                      }
                    },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.green),
                        ),child: const Text(
                            "Add trophy"
                        )),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
   bool load=false;
   File? image;
   Future<void> addTrophy(context) async {
     trophyData.add(false);
     trophyData.load(true);
     trophyData.error("");

     int random=DateTime.now().microsecond;
     var ref="$name$random";
     var imageRef= FirebaseStorage.instance.ref(ref);
     var task=await imageRef.putFile(trophyData.image!);
     var imageUrl=await task.ref.getDownloadURL();
     await FirebaseFirestore.instance.collection("Trophies").add({
       "Image Url":imageUrl,
       "Club Id":clubId,
       "Name":name,
       "Match":match,


     }).whenComplete(() {
       trophyData.load(false);
     });
   }
   String name="";
   String match="";
   Future gallery(context)async{
     Navigator.of(context).pop(true);
     var img= await ImagePicker.platform.pickImage(source: ImageSource.gallery);
     // image=File(img.path);
     trophyData.getImage(img!.path);

   }

   Future camera(context)async{
     Navigator.of(context).pop(true);
     // ignore: invalid_use_of_visible_for_testing_member
     var img= await ImagePicker.platform.pickImage(source: ImageSource.camera);
     trophyData.getImage(img!.path);
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
}
