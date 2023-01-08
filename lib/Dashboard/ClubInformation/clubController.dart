import 'package:flutter/foundation.dart';

class ClubData extends ChangeNotifier{
  String phone="";
  String area="";
  String address="";
  String email="";
  String pass="";
  String image="";
  String type="";
  String name="";
  void assignData(data){

    phone=data.get("Phone Number");
    area=data.get("Area");
    address=data.get("Address");
    name=data.get("Club Name");
    pass=data.get("Password");
    email=data.get("Email");
    type=data.get("Type");
    image=data.get("ImageUrl");
  }

}