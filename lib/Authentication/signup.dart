
import 'dart:io';
import 'dart:ui';
import 'package:image_picker/image_picker.dart';
import 'package:playerprofile/Authentication/user.dart';
import 'package:provider/provider.dart';

import 'spiner.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/material.dart';
import 'auth.dart';

class SignUp extends StatefulWidget {
  final  par;
  SignUp({this.par});
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {


  Future gallery()async{
    Navigator.of(context).pop(true);
    var img= await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    // image=File(img.path);
    setState(() {
      image=File(img!.path);
    });
  }

 Future camera()async{
   Navigator.of(context).pop(true);
   // ignore: invalid_use_of_visible_for_testing_member
   var img= await ImagePicker.platform.pickImage(source: ImageSource.camera);

   setState(() {
     image=File(img!.path);
   });
 }
String? simple="Visitor";
String? club="Club";
String? group="Visitor";
 InputDecoration deco(String text){
    return InputDecoration(
      labelText: '$text',
      labelStyle: TextStyle(fontSize: 12),
      border:OutlineInputBorder(
      borderRadius:BorderRadius.circular(12),
      borderSide:BorderSide(color: Colors.black,
      width: 2) ),


    );
  }
  InputDecoration decopass(String text){
    return InputDecoration(
      suffixIcon:  InkWell(
        onTap:(){
          setState(() {
            obscure=false;
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

  File? img(){
    return image;
  }
  String? hint;
  File? image;
  String email='';
  String phoneNumber='';
  String uname='';
  String address='';
  String shopName='';
  String pass='';
  String confirmPassword='';
  String error='';
  bool load=false;
  bool obscure=true;
  final AuthanticateUser _auth=AuthanticateUser();
  final _formKey =GlobalKey<FormState>();
  late UserType? userType;
  @override


  Widget build(BuildContext context) {
    userType= Provider.of<UserType>(context);
    return load ? Spiner():Scaffold(
        backgroundColor: Colors.white,
      // backgroundColor: Color(0xfffffeea),

        body:SingleChildScrollView(
          child: Form(
           autovalidateMode: AutovalidateMode.disabled,
            key:_formKey ,
            child: Padding(padding: const EdgeInsets.only(left: 12,top: 40,right: 12),
              child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
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
                              image:
                              image!=null?
                              Image.file(image!).image:
                              AssetImage('assets/images/logo.png',),fit: BoxFit.fill
                            )
                          ),
                                // child:image != null ?
                                ),
                      ),
                      InkWell(
                        splashColor:Colors.green,
                        onTap:(){showDialog(context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Choose Image',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)

                              ),
                              actions: <Widget>[
                                TextButton.icon(onPressed: camera,
                                    icon: Icon(Icons.camera,color: Colors.grey,size: 30,),
                                    label: Text('Camera',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
                                TextButton.icon(onPressed: gallery,
                                    icon: Icon(Icons.image,color: Colors.grey,size: 30),
                                    label: Text('Gallery',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)))

                              ],
                            ));},
                        child: Icon(
                            Icons.add_a_photo,
                            size: 30,
                            color: Colors.grey),
                      ),

                      Text('Add a Photo',
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,
                            fontSize: 12
                        ),),
                      ///Radio buttons
                      Row(
                        children: [
                          Radio<String>(
                              value:simple!,
                              groupValue:group,
                              onChanged: (val){
                                setState(() {
                                  print(val);
                                  group=val;
                                });
                              }),
                          Text("Vistor"),
                          Radio<String>(
                              value:club!,
                              groupValue:group,
                              onChanged: (val){
                                setState(() {
                                  group=val;
                                });

                              }),
                          Text("Club"),
                        ],
                      ),
                      ///Name
                      Padding(padding: const EdgeInsets.only(bottom: 20)),
                      TextFormField(
                          autovalidateMode:AutovalidateMode.always,
                        keyboardType: TextInputType.name,
                      validator: MultiValidator([
                      RequiredValidator(errorText: "Required"),
                        PatternValidator( ("[a-zA-Z $Spacer)]"),errorText: 'Only Characters')
                              ]),
                          onChanged: (val){
                          // setState(() {
                            uname=val;
                          // });
                          },
                          style: TextStyle(fontSize: 14),//password field
                          decoration:deco('NAME')),
                      ///Email
                      Padding(padding: EdgeInsets.all(5)),
                      TextFormField(
                          autovalidateMode:AutovalidateMode.always,
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Required"),
                            EmailValidator(errorText: "Invalid Email"),

                          ]),
                          onChanged: (val){
                            setState(() {
                              email=val;});},
                          style: TextStyle(fontSize: 14),//password field
                          decoration:deco('EMAIL')),
                      ///phone
                      Padding(padding: EdgeInsets.all(5)),
                      TextFormField(
                          autovalidateMode:AutovalidateMode.always,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Required"),
                            MaxLengthValidator(11, errorText: 'INVALID PHONE NUMBER'),
                            MinLengthValidator(11, errorText: 'INVALID PHONE NUMBER'),
                            PatternValidator( ("[0-9)]"),errorText: 'Only INTEGERS')
                          ]),
                          onChanged: (val){
                            setState(() {
                              phoneNumber=val;
                            });},
                          style: TextStyle(fontSize: 14),//password field
                          decoration:deco('PHONE NUMBER')),
                      ///Area selection
                      Padding(padding: EdgeInsets.all(5)),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(),
                            borderRadius: BorderRadius.circular(12.0)
                          ),
                          child: Center(
                            child: DropdownButtonFormField(
                              // autovalidateMode: AutovalidateMode.n,
                              validator: RequiredValidator(errorText: "Required"),
                              iconSize: 40,
                              isDense: true,
                              isExpanded:true,
                              hint: Text("Select Area",style: TextStyle(fontSize: 20.0),),
                              value: hint,
                              onChanged: (val){
                                // setState(() {
                                  hint=val;
                                // });
                              },

                              onSaved: (value) {
                                setState(() {
                                  hint = value;
                                });
                              },
                              items: [
                               DropdownMenuItem(child: Text("Select Area"),value:"Select Area",),
                               DropdownMenuItem(child: Text("Bhara Khu"),value: "bharaKhu",),
                               DropdownMenuItem(child: Text("Blue Area"),value: "bluearea"),
                               DropdownMenuItem(child: Text("Rawalpindi"),value: "rawalpindi"),
                               DropdownMenuItem(child: Text("Apara"),value: "apara"),
                              ],



                            ),
                          ),
                        ),
                      ),

                      ///Address
                      (group =="Club" )?Padding(padding: const EdgeInsets.only(bottom: 20)):Container(),
                      (group =="Club")?TextFormField(
                          autovalidateMode:AutovalidateMode.always,
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Required"),
                            // PatternValidator( ("[a-zA-Z $Spacer)]"),errorText: 'Only Characters')
                          ]),
                          onChanged: (val){
                            setState(() {
                              address=val;
                            });},
                          style: TextStyle(fontSize: 14),//password field
                          decoration:deco('ADDRESS')):Container(),
                      ///Password
                      Padding(padding: EdgeInsets.all(5)),
                      TextFormField(
                          autovalidateMode:AutovalidateMode.always,
                            obscureText: obscure,
                            validator: MultiValidator([
                            RequiredValidator(errorText: "Required"),
                             MinLengthValidator(6,errorText: 'minimum 6 character required ')
                            ]),
                            onChanged: (val){
                            setState(() {
                            pass=val;
                            print(pass);});},
                            style: TextStyle(fontSize: 14),//user name text input field
                              decoration:
                              decopass('PASSWORD')),
                      ///Confirm Password
                      Padding(padding: EdgeInsets.all(5)),
                      TextFormField(
                          autovalidateMode:AutovalidateMode.always,
                          obscureText: true,

                      validator:(val){
                          if(val!.isEmpty) {
                            return 'Required';
                          }
                          if(val.length<6){
                            return 'minimum 6 Character Required';
                          }
                          if(val!=pass){
                            return 'Pasword did not match';
                          }
                          return null;
                          },
                      onChanged: (val){
                              setState(() {
                              confirmPassword=val;
                            });},
                          style: TextStyle(fontSize: 14),//password field
                          decoration:deco('CONFIRM PASSWORD')),
                      ///Buttons
                      SizedBox(
                        child: Text(error,style: TextStyle(
                            fontSize: 14,
                            color: Colors.red
                        ),),
                      ),
                      ElevatedButton(
                        onPressed: ()async{
                          if(_formKey.currentState!.validate()&& image!=null ) {
                            setState(() {
                              load=true;
                            });
                            userType!.setType(group);
                          dynamic result = await _auth.Signup(email, pass,image,uname,phoneNumber,group,address,shopName,hint);
                          if(result!=null){
                            setState(() {
                              load=false;
                              Navigator.of(context).pop(true);

                            });
                          }
                          if (result == null) {
                            setState(() {
                              error = 'somting went wrong';
                            load=false;
                            });
                          }}
                          if(image==null){
                            setState(() {
                              error='Please upload a pohto';
                            });
                          }
                          },

                      //   shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(18.0)
                      // ),
                        child: Text(
                          'SIGNUP',
                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
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
                          // borderRadius: BorderRadius.circular(18.0)),
                        child: Text(
                          '   EXIT  ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)
                         ),
                          // color:Colors.red
                      )
                    ],
                  ),

      ),


          ),
        ),

    );
  }
}

