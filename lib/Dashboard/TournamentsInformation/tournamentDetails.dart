import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class Details extends StatefulWidget {
  final data;
  final type;
  final clubId;
  const Details({Key? key,this.data,this.type,this.clubId}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  double height=0.0;
  double width=0.0;
  List abc=[];
  var colRef=FirebaseFirestore.instance.collection("Tournaments");
  var colRefClubs=FirebaseFirestore.instance.collection("clubs");

  @override

  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Details"
        ),
        elevation: 20,
        shadowColor: Colors.blue,
        actions: [
          widget.type=="self"?IconButton(onPressed: (){
            showDialog(context: context, builder: (_)=>AlertDialog(
              title: Text("Are you sure you want to delete this tournament."),
              actions: [
                TextButton(onPressed: (){
                  removeTournament();
                }, child: Text("Yes")),
                TextButton(onPressed: (){
                Navigator.pop(context);
                }, child: Text("No")),

              ],
            ));

          }, icon: const Icon(Icons.delete,color: Colors.white,)):Container()
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 30,
            color: Colors.blue.shade200,
            child: Center(
              child: Text(widget.data.get("Tournament Name")),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Wining Price:\t\t${widget.data.get("Wining Price")}",style:detail(0.018) ,),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Entry Fee:\t\t${widget.data.get("Entry Fee")}",style:detail(0.018)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Start Date:\t\t${widget.data.get("Start Date")}",style:detail(0.018)),
                widget.type=="other" && widget.data.get("Joined Clubs").contains(widget.clubId)==false?ElevatedButton(onPressed: (){
                        addEntry();
                }, child: Text("Send Entry")):Container()
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("<--Joined Clubs-->",style:detail(0.018)),
          ),
          Center(
            child: Container(
              height: height*0.65,
              width: width*0.9,
              decoration:  BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(color: Colors.black12,blurRadius: 1,spreadRadius: 1)
                ]
              ),
              child: Center(
                child:Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ListView.builder(
                              itemCount:widget.data.get("Joined Clubs").length ,
                              itemBuilder: (_,index){
                                return StreamBuilder(
                                    stream: colRefClubs.doc(widget.data.get("Joined Clubs")[index]).snapshots(),
                                    builder: (_,snap){
                                      if(snap.data!=null){
                                        return ListTile(
                                          leading: CircleAvatar(
                                            radius: 25,
                                            backgroundColor: Colors.black,
                                            backgroundImage: NetworkImage(snap.data!.get("ImageUrl")),
                                          ),
                                          title: Text(snap.data!.get("Club Name")),
                                          subtitle: Text("${snap.data!.get("Area")}"),
                                        );
                                      }
                                      else{
                                        return const Center(
                                          child: Text("No Tournament Found"),
                                        );
                                      }


                                    });
                              }),
                )


            ),),
          )
    ]
      ),
    );
  }
  TextStyle detail(font){
    return TextStyle(
      fontSize: height*font,
    );
  }
  void addEntry()async{
    var list=widget.data.get("Joined Clubs");
    list.add(widget.clubId);
    await FirebaseFirestore.instance.collection("Tournaments").doc(widget.data.id).update({
      "Joined Clubs":list
    }).whenComplete(() {
     Navigator.pop(context);});
  }
  Future<void> removeTournament() async {

    await FirebaseFirestore.instance.collection("Tournaments").doc(widget.data.id).delete().
    whenComplete(() {
      Navigator.pop(context); Navigator.pop(context);});
  }
}
