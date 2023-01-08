import 'package:flutter/cupertino.dart';

class PlayerData extends ChangeNotifier{
  String name="";
  String phone="";
  String age="";
  String matches="";
  String century="";
  String fifty="";
  String best="";
  String runs="";
  String average="";
  String image="";
  String clubId="";
  void setData(data){
    name=data.get("Player Name");
    phone=data.get("Phone Number");
    age=data.get( "Age");
    matches=data.get( "Matches");
    century=data.get("century");
    fifty=data.get("Average");
    best=data.get("Best");
    runs=data.get("Runs");
    average=data.get("fifty");
    clubId=data.get("Club Id");
    image=data.get("Image Url");











  }
}