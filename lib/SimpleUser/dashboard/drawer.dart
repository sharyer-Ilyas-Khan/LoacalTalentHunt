import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../Authentication/auth.dart';
import '../../../Authentication/login.dart';
import '../../../Authentication/signup.dart';
import '../../../Authentication/user.dart';
class CustomDrawer extends StatelessWidget {
   CustomDrawer({Key? key}) : super(key: key);
  AuthanticateUser _auth= AuthanticateUser();
  @override
  Widget build(BuildContext context) {
    final user= Provider.of<User?>(context);
    return Drawer(
      child: Column(
        children: [
          (user != null)?
          StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection("visitor").doc(user.uid).snapshots(),
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return
                  UserAccountsDrawerHeader(
                      decoration: const BoxDecoration(
                          color: Colors.black
                      ),
                      accountName: Text(snapshot.data!.get('Visitor Name').toUpperCase()),
                      accountEmail: Text(snapshot.data!.get('Email')),
                      currentAccountPicture: CircleAvatar(
                        radius: 9,
                        backgroundColor: Colors.grey,
                        backgroundImage: NetworkImage(snapshot.data!.get('ImageUrl'),
                      )

                  ));
                }
                else{
                  return const UserAccountsDrawerHeader(
                      decoration:  BoxDecoration(
                          color: Colors.black
                      ),
                      accountName: Text('User Name'),
                      accountEmail: Text('Email'),
                      currentAccountPicture: CircleAvatar(
                          radius: 9,
                          backgroundColor: Colors.grey,
                          backgroundImage: AssetImage("assets/images/logo.png"),
                          )

                      );
                }}):
         const UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.black
              ),
              accountName: Text('Your Name'),
              accountEmail: Text('Email'),
              currentAccountPicture: CircleAvatar(
                radius: 9,
                backgroundColor: Colors.grey,
                backgroundImage: AssetImage('assets/images/logo.png'),
                // backgroundImage: AssetImage('assets/images/logo.png'),
              )

          ),
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                children: [
                  ListTile(
                    title: Text("Profile",
                        style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey.shade800)),
                    leading: const Icon(Icons.person,color: Colors.black,),
                  ),
                  const Divider(thickness: 2),
                  (user!=null)?InkWell(
                    onTap: (){

                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Login()));
                      _auth.singout();
                    },
                    child: ListTile(
                      title: Text("Logout",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey.shade800)),
                      leading: const Icon(Icons.logout,color: Colors.black,),
                    ),
                  ):
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>SignUp()));
                    },
                    child: ListTile(
                      title: Text("Sign Up",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey.shade800)),
                      leading: const Icon(Icons.vpn_key,color: Colors.amber),

                    ),
                  ),
                  (user!=null)?const Divider(thickness: 2):const Divider(thickness: 2),
                  (user!=null)?Container():InkWell(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Login()));
                    },
                    child: ListTile(
                      title: Text("Login",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey.shade800)),
                      leading: const Icon(Icons.logout,color: Colors.black,),
                    ),
                  ),
                  (user!=null)?Container():const Divider(thickness: 2),
                  InkWell(
                    onTap: (){
                      SystemNavigator.pop();
                    },
                    child: ListTile(
                      title: Text("Quit",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey.shade800)),
                      leading: const Icon(Icons.power_settings_new,color: Colors.red,),
                    ),
                  ),
                  const Divider(thickness: 2),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  TextStyle styles(color,size,weight){
    return TextStyle(
        color: color,
        fontWeight: FontWeight.normal,
        fontSize: size,
        fontFamily: "com"
    );
  }
}
