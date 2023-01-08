import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fb;
import 'package:playerprofile/Authentication/user.dart';
import 'package:playerprofile/Dashboard/ClubInformation/clubController.dart';
import 'package:provider/provider.dart';
class DisplayClubInfoData extends StatelessWidget {
  final collection;
   DisplayClubInfoData({Key? key,this.collection}) : super(key: key);

var refCol=fb.FirebaseFirestore.instance.collection("clubs");
late User user;
late ClubData clubData;
  @override
  Widget build(BuildContext context) {
    user=Provider.of<User>(context);
    clubData=Provider.of<ClubData>(context);
    print(user.uid);
    return StreamBuilder(
      stream:refCol.doc(user.uid).snapshots(),
      builder: (_,snap) {

        if(snap.data!=null){
          clubData.assignData(snap.data);
          return Row(
            children: [
               Expanded(
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.black,
                    backgroundImage: NetworkImage(snap.data!.get("ImageUrl"))
                    // foregroundImage: AssetImage("assets/images/logo.png"),


                  )),
              Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Name:", style: styles(Colors.black, 12.0,),),
                            Text("Phone:", style: styles(Colors.black, 12.0,),),
                            Text("Email:", style: styles(Colors.black, 12.0,),),
                            Text("Area:", style: styles(Colors.black, 12.0,),),
                            Text("Address:", style: styles(Colors.black, 12.0,),),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(snap.data!.get("Club Name"), style: styles(Colors.blue, 12.0,),),
                          Text(snap.data!.get("Phone Number"), style: styles(Colors.blue, 12.0,),),
                          Text(snap.data!.get("Email"), style: styles(Colors.blue, 12.0,),),
                          Text(snap.data!.get("Area"), style: styles(Colors.blue, 12.0,),),
                          SizedBox(width:150,height: 15,child: Text(snap.data!.get("Address"),overflow: TextOverflow.ellipsis, style: styles(Colors.blue, 12.0,),)),
                        ],
                      ),
                    ],
                  )
              )
            ],
          );
        }
        else{
          return Row(
            children: [
              const Expanded(
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.black,
                    backgroundImage: AssetImage("assets/images/logo.png"),
                    // foregroundImage: AssetImage("assets/images/logo.png"),


                  )),
              Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Name:", style: styles(Colors.black, 12.0,),),
                            Text("Phone:", style: styles(Colors.black, 12.0,),),
                            Text("Email:", style: styles(Colors.black, 12.0,),),
                            Text("Area:", style: styles(Colors.black, 12.0,),),
                            Text("Address:", style: styles(Colors.black, 12.0,),),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("loading...", style: styles(Colors.blue, 12.0,),),
                          Text("loading...", style: styles(Colors.blue, 12.0,),),
                          Text("loading...", style: styles(Colors.blue, 12.0,),),
                          Text("loading...", style: styles(Colors.blue, 12.0,),),
                          SizedBox(width:150,height: 15,child: Text("loading...",overflow: TextOverflow.ellipsis, style: styles(Colors.blue, 12.0,),)),
                        ],
                      ),
                    ],
                  )
              )
            ],
          );
        }

      }
    );
  }
  TextStyle styles(color,size){
    return TextStyle(
        color: color,
        fontWeight: FontWeight.normal,
        fontSize: size,
        fontFamily: "com"
    );
  }
}
