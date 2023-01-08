import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:playerprofile/Authentication/spiner.dart';
class AddTournament extends StatefulWidget {
  final clubId;
   AddTournament({Key? key,this.clubId}) : super(key: key);

  @override
  State<AddTournament> createState() => _AddTournamentState();
}

class _AddTournamentState extends State<AddTournament> {
  double height=0.0;
  double width=0.0;
  final _formKey =GlobalKey<FormState>();
  @override
  void initState() {
    startDate=DateTime.now();
    endDate=DateTime.now();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
          title: Text("Add Tournament"),
      ),
      body: load?Spiner():Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.only(left: width*0.1,right:width*0.1 ),
          child: ListView(
            children: [
              SizedBox(height: 8,),
              SizedBox(
                  height: height * 0.1,
                  width: width * 0.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween,
                    children: [
                      Text("Starting Date:${startDate
                          .toString()
                          .split(" ")
                          .first}",
                        style: TextStyle(fontSize: 12),),
                      IconButton(onPressed: () async {

                        startDate =
                        await showDatePicker(context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2022),
                          lastDate: DateTime(2050),


                        );
                        setState((){});
                      },
                          icon: Icon(Icons.date_range,
                            color: Colors.blue,))
                    ],
                  )
              ),
              SizedBox(height: 8,),
              SizedBox(
                height: height*0.1,

                child: TextFormField(
                    autovalidateMode:AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.name,
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Required"),
                      PatternValidator( ("[a-zA-Z $Spacer)]"),errorText: 'Only Characters')
                    ]),
                    onChanged: (val){
                      name=val;
                    },
                    style: const TextStyle(fontSize: 12),//password field
                    decoration:deco('Name of tournament')),
              ),
              SizedBox(height: 8,),
              SizedBox(
                height: height*0.1,

                child: TextFormField(
                    autovalidateMode:AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Required"),
                      PatternValidator( ("[0-9)]"),errorText: 'Only INTEGERS')
                    ]),
                    onChanged: (val){
                      entryFee=val;
                    },
                    style: const TextStyle(fontSize: 12),//password field
                    decoration:deco('Entry Fee')),
              ),
              SizedBox(height: 8,),
              SizedBox(
                height: height*0.1,

                child: TextFormField(
                    autovalidateMode:AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Required"),
                      PatternValidator( ("[0-9)]"),errorText: 'Only INTEGERS')
                    ]),
                    onChanged: (val){
                      numberOfClubs=val;
                    },
                    style: const TextStyle(fontSize: 12),//password field
                    decoration:deco('Max Number of clubs')),
              ),
              SizedBox(height: 8,),
              SizedBox(
                height: height*0.1,

                child: TextFormField(
                    autovalidateMode:AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Required"),
                      PatternValidator( ("[0-9)]"),errorText: 'Only INTEGERS')
                    ]),
                    onChanged: (val){
                      price=val;},
                    style: const TextStyle(fontSize: 12),//password field
                    decoration:deco('Wining price')),
              ),
              SizedBox(height: 8,),
              SizedBox(
                height: height*0.1,

                child: TextFormField(
                    autovalidateMode:AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.name,
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Required"),
                      PatternValidator( ("[a-zA-Z $Spacer)]"),errorText: 'Only Characters')
                    ]),
                    onChanged: (val){
                      ground=val;
                    },
                    style: const TextStyle(fontSize: 12),//password field
                    decoration:deco('Ground Name')),
              ),

              SizedBox(height: 8,),
              SizedBox(
                  height: height * 0.1,
                  width: width * 0.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween,
                    children: [
                      Text("Ending Date:${endDate
                          .toString()
                          .split(" ")
                          .first}",
                        style: TextStyle(fontSize: 12),),
                      IconButton(onPressed: () async {

                        endDate =
                        await showDatePicker(context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2022),
                          lastDate: DateTime(2050),


                        );
                        setState((){});
                      },
                          icon: Icon(Icons.date_range,
                            color: Colors.blue,))
                    ],
                  )
              ),
              SizedBox(height: 8,),

              Center(
                child: Text(errorText,style: TextStyle(color: Colors.red),),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: (){
                    if(_formKey.currentState!.validate()){
                        if(startDate !=null && endDate!=null){
                          addTournament();
                        }
                      else{
                        setState(() {
                          errorText="Dates are missing";
                        });
                      }
                    }
                  },
                  child:const  Text("Add"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  InputDecoration deco(String text){
    return InputDecoration(
      labelText: '$text',
      border:OutlineInputBorder(
          borderRadius:BorderRadius.circular(12),
          borderSide:BorderSide(color: Colors.black,
              width: 2) ),


    );
  }
  String errorText="";
  String name="";
  String entryFee="";
  String numberOfClubs="";
  String matches="";
  String century="";
  String fifty="";
  String price="";
  String ground="";
  String average="";
  DateTime? startDate;
  DateTime? endDate;
  bool load=false;
  void addTournament()async{
    setState(() {
      load=true;
    });
    await FirebaseFirestore.instance.collection("Tournaments").add({
      "Start Date":startDate
          .toString()
          .split(" ")
          .first,
      "End Date":endDate
          .toString()
          .split(" ")
          .first,
      "Club Id":widget.clubId,
      "Tournament Name":name,
      "Entry Fee":entryFee,
      "Wining Price":price,
      "Ground Name":ground,
      "Maximum Clubs":numberOfClubs,
      "Joined Clubs":[widget.clubId]


    }).whenComplete(()  {
      load=false;
      Navigator.pop(context);
      setState((){
        errorText="";
      });
    });
  }
}
