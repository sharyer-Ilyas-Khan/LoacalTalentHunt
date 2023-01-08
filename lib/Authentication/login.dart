import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:playerprofile/Authentication/user.dart';
import 'package:provider/provider.dart';

import '../Dashboard/MainScreens/dashboard.dart';
import '../SimpleUser/dashboard/userDashboard.dart';
import 'RestPass.dart';
import 'spiner.dart';
import 'package:flutter/services.dart';

import 'auth.dart';
import 'signup.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Login extends StatefulWidget {
  final  par;
  Login({ this.par});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  InputDecoration deco(String text){
    return InputDecoration(
      labelText: '$text',
      border:OutlineInputBorder(
          borderRadius:BorderRadius.circular(12),
          borderSide:BorderSide(color: Colors.black,
              width: 2) ),


    );
  }
  bool obscr=true;
  InputDecoration decopass(String text){
    return InputDecoration(
      suffixIcon:  InkWell(
          onTap:(){
            setState(() {
              obscr=false;
            });
          },
          child:Icon(Icons.remove_red_eye)),
      labelText: '$text',
      labelStyle: TextStyle(fontSize: 12),
      border:OutlineInputBorder(
          borderRadius:BorderRadius.circular(12),
          borderSide:BorderSide(color: Colors.black,
              width: 2) ),


    );
  }

  bool load=false;
  String email='';
  String pass='';
  String erorr='';
  final AuthanticateUser _auth=AuthanticateUser();
  final _formkey =GlobalKey<FormState>();
  late UserType? userType;
  @override


  Widget build(BuildContext context) {
    userType= Provider.of<UserType>(context);
    return load ? Spiner(): Scaffold(
        // backgroundColor: Color(0xfffffeea),
        backgroundColor: Colors.white,

       //signup
        body: Padding(padding: const EdgeInsets.only(left: 12,right: 12,top:80),
          child:Form(
            key: _formkey,
              autovalidateMode:AutovalidateMode.always,
              child:SingleChildScrollView(
              child:Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                streamOfClubs(),
                //Image.asset('images/logo.png',width: 300,height: 200,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.12,
                    width: MediaQuery.of(context).size.width*0.35,
                    decoration: BoxDecoration(
                      color: Colors.black,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.cyan,width: 3),
                        image: DecorationImage(
                            image: AssetImage('assets/images/logo.png'),
                          fit: BoxFit.cover
                        )
                    ),
                  ),
                ),
                Text("LOGIN",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),


                Padding(padding: EdgeInsets.only(top: 20)),
                 TextFormField(
                        validator: MultiValidator([
                    RequiredValidator(errorText: "Required"),
                    EmailValidator(errorText: "Invalid Email"),
                        ]),
                        onChanged: (val){
                          setState(() {
                            email=val;});},
                  style: TextStyle(fontSize: 12),//password field
                  decoration:deco('Email')),
              Padding(padding:EdgeInsets.only(bottom: 5)),
                  TextFormField(
                  obscureText: obscr,
                      validator: MultiValidator([
                    RequiredValidator(errorText: "Required"),
                    MinLengthValidator(6,errorText: 'minimum 6 character required ')
                  ]),
                onChanged: (val){
                setState(() {
                pass=val;});},
                      style: TextStyle(fontSize: 12),//password field
                  decoration:decopass('PASSWORD'))
                ,
               TextButton(onPressed: (){
                  setState(() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>ResetScreen()));
                  });
                },
                    child: Text("Reset Password?")),
                TextButton(onPressed: (){
                  // setState(Change);
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => SignUp()
                  ));
                },
                    child: Text("Create Account")),

                SizedBox(
                  child: Text(erorr,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),

                  ),
                ),
              ElevatedButton(onPressed:()async {
                if(_formkey.currentState!.validate()){
                  setState(() {
                    load=true;
                  });

                  if(clubsEmails.contains(email)){
                    userType!.setType("clubs");
                    dynamic result = await _auth.Signin(email, pass);
                    if(result!=null){
                      setState(() {
                        load=false;
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Dashboard()));
                        // Navigator.pop(context);
                      });
                    }
                    if (result == null) {
                      setState(() {
                        erorr = 'somting went wrong';
                        load=false;
                      });
                    }
                  }
                  else{
                    userType!.setType("Visitor");
                    dynamic result = await _auth.Signin(email, pass);
                    if(result!=null){
                      setState(() {
                        load=false;
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>UserDashboard()));

                      });
                    }
                    if (result == null) {
                      setState(() {
                        erorr = 'somting went wrong';
                        load=false;
                      });
                    }

                  }
                 }},

                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(18.0)
                // ),
                child: Text('LOGIN',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              // color: Colors.black,

              ),

              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red)

                ),
                onPressed: (){

               showDialog(

                  context: context,
                  builder: (context)=> AlertDialog(
                    title: Text("Warning"),
                    content: Text("Are you sure want to Exit"),
                    actions: <Widget>[
                     TextButton(onPressed: (){
                       SystemNavigator.pop();
                     },child: Text("Yes"),),
                      TextButton(onPressed: (){
                        Navigator.of(context).pop(false);
                      },child: Text("No"),),
                    ],
                  )
                  );

                },
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(18.0)
                // ),
                child: Text('  EXIT ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
              // color: Colors.red
              ),

            ],
          ),
        )
        ),)
    );
  }
  CollectionReference userCol=FirebaseFirestore.instance.collection('visitor');
  CollectionReference clubCol=FirebaseFirestore.instance.collection('clubs');
  List clubsEmails=[];
  List visitorsEmails=[];
  streamOfClubs(){
    return StreamBuilder(
        stream: clubCol.snapshots(),
        builder: (_,snap){
          if(snap.data!=null && snap.data!.docs.isNotEmpty){
            for(int i=0;i<snap.data!.docs.length;i++){
              if(clubsEmails.contains(snap.data!.docs[i].get("Email"))==false){
                clubsEmails.add(snap.data!.docs[i].get("Email"));
              }
            }
            print(clubsEmails);
          }

      return Container();
    });
  }
  streamOfVisitor(){
    return StreamBuilder(
        stream: userCol.snapshots(),
        builder: (_,snap){
    if(snap.data!=null && snap.data!.docs.isNotEmpty){
      for(int i=0;i<snap.data!.docs.length;i++){
        if(visitorsEmails.contains(snap.data!.docs[i].get("Email"))==false){
          visitorsEmails.add(snap.data!.docs[i].get("Email"));
        }

      }
      print(visitorsEmails);
    }

          return Container();
        });
  }

}

