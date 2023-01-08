
import 'package:flutter/material.dart';
import 'package:playerprofile/Authentication/login.dart';
import 'package:playerprofile/SimpleUser/dashboard/userDashboard.dart';
import 'package:provider/provider.dart';
import '../Dashboard/MainScreens/dashboard.dart';
import 'user.dart';

class Wrapper extends StatelessWidget {
  late UserType userType;
  @override
  Widget build(BuildContext context) {

    final user= Provider.of<User?>(context);
   userType= Provider.of<UserType?>(context)!;
   print(userType.type);
    if(user==null){
      return Login();
    }
    else
      {
        print(userType.type);
        return userType.type=="Visitor"?UserDashboard():Dashboard();
        // return Dashboard();
      }
  }
}
