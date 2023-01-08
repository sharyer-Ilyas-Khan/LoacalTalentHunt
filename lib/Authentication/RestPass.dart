import 'dart:ui';

import 'login.dart';
import 'spiner.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'auth.dart';

class ResetScreen extends StatefulWidget {
  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {




  @override


  bool load=false;
  String? email;
  Color? clr;
  String error='';
  final _formkey =GlobalKey<FormState>();
  final AuthanticateUser _auth=AuthanticateUser();

  Widget build(BuildContext context) {

    return load?Spiner(): Scaffold(
        // backgroundColor: Color(0xfffffeea),
        backgroundColor: Colors.white,
        body: Form(
        key: _formkey,
            autovalidateMode:AutovalidateMode.always,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height*0.12,
                  width: MediaQuery.of(context).size.width*0.35,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.cyan,width: 3),
                      image: const DecorationImage(
                          image: AssetImage('assets/images/logo.png'),
                          fit: BoxFit.cover
                      )
                  ),
                ),
              ),
              const Text("Reset Password",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),


              Padding(padding: EdgeInsets.only(top: 20)),

              Text('Enter your Email Adddress',
                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
              Padding(padding: EdgeInsets.only(top: 40,left: 10,right: 10),
                  child: SizedBox(height:100,
                      child: TextFormField(
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Required"),
                            EmailValidator(errorText: "Invalid Email"),
                          ]),
                          onChanged: (val){
                            setState(() {
                              email=val;});},
                          style: TextStyle(fontSize: 12),//password field
                          decoration:InputDecoration(
                            labelText: 'Email',

                            border:OutlineInputBorder(
                            borderRadius:BorderRadius.circular(18),
                            borderSide:BorderSide(color: Colors.black,
                            width: 2) ),
                            ))),
        ),
              Padding(padding: EdgeInsets.all(20),
                  child:SizedBox(
                    height: 30,
                    child: Text(error,style: TextStyle(
                        fontSize: 16,
                        color: clr)),
                  )),
          ElevatedButton(onPressed:()async {
            if(_formkey.currentState!.validate()){
              setState(() {
                load=true;
              });
              dynamic result = await _auth.resetPass(email!);

              if (result == null) {
                setState(() {
                  error = 'somting went wrong';
                  clr=Colors.red;
                  load=false;
                });
              }
              if(result==''){
                setState(() {
                  error='Reset password sent to ${email} ';
                  clr=Colors.blue;
                  load=false;
                });
              }
            }},
      //         shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(18.0)
      // ),
      child: Text('RESET',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
      // color: Colors.black,
    ),
           ElevatedButton(onPressed: (){
             setState(() {
               Navigator.pushReplacement(context,
                   MaterialPageRoute(builder: (context) =>Login()));
             });
           },

             // shape: RoundedRectangleBorder(
             //     borderRadius: BorderRadius.circular(18.0)
             // ),

             child: Text('LOGIN',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
             // color: Colors.black,

           )
            ],
          )


      ),
    );
  }
}
