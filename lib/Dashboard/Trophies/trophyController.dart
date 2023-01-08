import 'dart:io';

import 'package:flutter/cupertino.dart';

class TrophyData extends ChangeNotifier{
  File? image;
  bool isLoad=false;
  bool adding=false;
  String errorText="";
  void getImage(value){
    image=File(value);
    notifyListeners();
  }
  void load(value){
    isLoad=value;
    notifyListeners();
  }
  void add(value){
    adding=value;
    notifyListeners();
  }
  void error(text){
    errorText=text;
    notifyListeners();
  }
}