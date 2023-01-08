import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MatchesHome extends StatefulWidget {
  final clubId;
  const MatchesHome({Key? key,this.clubId}) : super(key: key);

  @override
  State<MatchesHome> createState() => _MatchesHomeState();
}

class _MatchesHomeState extends State<MatchesHome> {
  double height=0.0;
  double width=0.0;
  var colRef=FirebaseFirestore.instance.collection("Matches");
@override
  void initState() {
   date=DateTime.now();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Matches"),
        actions: [
          IconButton(onPressed: (){
            showDialog(context: context, builder: (_)=>
                StatefulBuilder(
                  builder: (_,setState) {
                    return AlertDialog(
                      content: SizedBox(
                        height: height * 0.6,
                        width: width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                                height: height * 0.055,
                                width: width * 0.8,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text("All feilds are required",
                                        style: TextStyle(fontSize: 12)),
                                    IconButton(
                                      icon: Icon(Icons.cancel),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                )
                            ),
                            SizedBox(
                                height: height * 0.055,
                                width: width * 0.8,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text("Date:${date
                                        .toString()
                                        .split(" ")
                                        .first}",
                                      style: TextStyle(fontSize: 12),),
                                    IconButton(onPressed: () async {

                                      date =
                                      await showDatePicker(context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime.now(),


                                      );
                                      setState((){});
                                    },
                                        icon: Icon(Icons.date_range,
                                          color: Colors.blue,))
                                  ],
                                )
                            ),
                            Container(
                              height: height * 0.055,
                              width: width * 0.8,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.black38)
                              ),
                              child: Center(
                                child: Text(
                                  "Own Club", style: TextStyle(fontSize: 12),),
                              ),
                            ),
                            Text("vs", style: TextStyle(fontSize: 12)),
                            SizedBox(
                              height: height * 0.055,
                              width: width * 0.8,
                              child: TextFormField(

                                  onChanged: (val) {
                                   clubName=val;
                                  },
                                  style: const TextStyle(fontSize: 12),
                                  //password field
                                  decoration: deco('Club Name')),
                            ),
                            // SizedBox(
                            //   height: height*0.055,
                            //   width: width*0.8,
                            //   child: TextFormField(
                            //
                            //       onChanged: (val){
                            //         setState(() {
                            //           // email=val;
                            //         });},
                            //       style: const TextStyle(fontSize: 12),//password field
                            //       decoration:deco('Name of Match')),
                            // ),
                            Text("result", style: TextStyle(fontSize: 12)),
                            SizedBox(
                              height: height * 0.055,
                              width: width * 0.8,
                              child: TextFormField(

                                  onChanged: (val) {
                                    result=val;
                                  },
                                  style: const TextStyle(fontSize: 12),
                                  //password field
                                  decoration: deco('win/lose/draw')),
                            ),
                            Text(error, style: TextStyle(fontSize: 12,color: Colors.red)),
                            ElevatedButton(onPressed: () {
                              if(result!=""&& clubName!=""){
                                addMatch();
                              }
                              else{
                                setState((){
                                  error="All fields are required";
                                });
                              }
                            },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.green),
                                ), child: const Text(
                                    "Add Match"
                                )),
                          ],
                        ),
                      ),
                    );
                  }
                ));
          }, icon:
          const Icon(Icons.add_circle_outline_rounded,color: Colors.white,))
        ],
      ),
      body: StreamBuilder(
          stream: colRef.where("Club Id",isEqualTo: widget.clubId).snapshots(),
          builder: (_,snap){
            if(snap.data!=null && snap.data!.docs.isNotEmpty) {
              return ListView.builder(
                  itemCount: snap.data!.docs.length,
                  itemBuilder: (_, index) {
                    return ListTile(
                      leading: Container(
                        height: 35,
                        width: 35,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            image: AssetImage("assets/images/cricket.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      title: Text(
                          "Us vs ${snap.data!.docs[index].get("Club Name")}"),
                      subtitle: Row(
                        children: [

                          Text("Result: ${snap.data!.docs[index].get(
                              "Result")}\t\t"),
                          Text("Date: ${snap.data!.docs[index].get("Date")}")

                        ],
                      ),

                    );
                  }
              );
            }
            else{
              return  Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(height:20),
                    Text("No Match Found"),
                  ],
                ),
              );
            }
        }
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
  DateTime? date;
String clubName="";
String result="";
String error="";
void addMatch()async{
    await FirebaseFirestore.instance.collection("Matches").add({
      "Club Id":widget.clubId,
      "Club Name":clubName,
      "Result":result,
      "Date":date
          .toString()
          .split(" ")
          .first


    }).whenComplete(() {
     Navigator.pop(context);
     setState((){
       error="";
     });
    });
}
}