import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:playerprofile/Dashboard/PlayerInformation/playerController.dart';
import 'package:provider/provider.dart';

class DisplayPlayerInfoData extends StatelessWidget {
  final data;
   DisplayPlayerInfoData({Key? key,this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PlayerData playerData=Provider.of<PlayerData>(context);
    playerData.setData(data);
    return Row(
      children: [
        Expanded(
            child: CircleAvatar(
                radius: 55,
                backgroundColor: Colors.black,
                backgroundImage: NetworkImage(data!.get("Image Url"))
              // foregroundImage: AssetImage("assets/images/logo.png"),


            )),
        Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("AGE:", style: styles(Colors.black, 12.0,),),
                    Text("Matches:", style: styles(Colors.black, 12.0,),),
                    Text("100/50s:", style: styles(Colors.black, 12.0,),),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data!.get("Age"), style: styles(Colors.blue, 12.0,),),
                    Text(data!.get("Matches"), style: styles(Colors.blue, 12.0,),),
                    Text("${data!.get("century")}/${data!.get("fifty")}", style: styles(Colors.blue, 12.0,),),
                  ],
                ),
                const SizedBox(width: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Best:", style: styles(Colors.black, 12.0,),),
                    Text("Runs:", style: styles(Colors.black, 12.0,),),
                    Text("Avg:", style: styles(Colors.black, 12.0,),),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data!.get("Best"), style: styles(Colors.blue, 12.0,),),
                    Text(data!.get("Runs"), style: styles(Colors.blue, 12.0,),),
                    Text(data!.get("Average"), style: styles(Colors.blue, 12.0,),),
                  ],
                ),
              ],
            )
        )
      ],
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
