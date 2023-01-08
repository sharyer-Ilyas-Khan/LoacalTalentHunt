import 'package:flutter/material.dart';

class User extends ChangeNotifier{
  final uid;

  User({this.uid});

}
class UserType extends ChangeNotifier{
  String? type;
  void setType(value){
    type=value;
    notifyListeners();
  }}
