import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class DashboardController extends ChangeNotifier{
  String type="";
 void getType(value){
   value=type;
   notifyListeners();
 }

}