import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:playerprofile/SimpleUser/clubs/displayInfo.dart';
import 'package:video_player/video_player.dart';

import '../players/playerInfo.dart';
class ClubInfo extends StatefulWidget {
  final clubId;
  final VideoUrl;
  const ClubInfo({Key? key,this.clubId,this.VideoUrl}) : super(key: key);

  @override
  State<ClubInfo> createState() => _ClubInfoState();
}

class _ClubInfoState extends State<ClubInfo> {
  double height=0.0;
  double width=0.0;
  var colRef=FirebaseFirestore.instance.collection("Players");
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        widget.VideoUrl,
        )
      ..initialize(
      ).then((_) {
        _controller.setLooping(true);
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _controller.play();
        });
      });
  }
  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Club Information"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: height*0.2,
            child: Padding(
              padding:  EdgeInsets.all(8.0),
              child: DisplayClubInfoData(clubId: widget.clubId,),
            ),
          ),
          Expanded(child: SizedBox(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("All Players:"),
                ),
                Center(
                  child: Container(

                      height: height*0.3,
                      width: width*0.9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(color: Colors.black12)
                      ),
                      child:StreamBuilder(
                          stream: colRef.where("Club Id",isEqualTo: widget.clubId).snapshots(),
                          builder: (_,snap){
                            if(snap.data!=null && snap.data!.docs.isNotEmpty){
                              return ListView.builder(
                                  itemCount:snap.data!.docs.length ,
                                  itemBuilder: (_,index){
                                    return InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (_)=>PlayerInfo(data:snap.data!.docs[index])));

                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            radius: 25,
                                            backgroundColor: Colors.black,
                                            backgroundImage: NetworkImage(snap.data!.docs[index].get("Image Url")),
                                          ),
                                          title: Text(snap.data!.docs[index].get("Player Name")),
                                          subtitle: Text("${snap.data!.docs[index].get("Phone Number")}\n tap for more..."),
                                        ),
                                      ),
                                    );
                                  });
                            }
                            else{
                              return const Center(
                                child: Text("No Player Found"),
                              );
                            }


                          })
                  ),
                ),
                Container(
                  height: height*0.4,
                  width: width*0.9,
                  color: Colors.black,
                  child: Stack(
                    children: [
                      VideoPlayer(_controller),
                      Center(
                        child: IconButton(
                          onPressed: (){
                            setState(() {
                              _controller.value.isPlaying
                                  ? _controller.pause()
                                  : _controller.play();
                            });
                          },
                          icon: Icon( _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,color: Colors.white,size: 40,),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: height*0.6,
                  width: width*0.8,
                  child: GridView.count(crossAxisCount: 2,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    scrollDirection: Axis.horizontal,
                    children: [
                    Image(image: NetworkImage("https://i0.wp.com/buybest.pk/wp-content/uploads/2021/10/post_image_d3a5c95.jpg?fit=1440%2C960&ssl=1"),fit: BoxFit.fill,),
                    Image(image: NetworkImage("https://cdn.shopify.com/s/files/1/0014/3789/2697/products/AquaMan_1024x1024.jpg?v=1609488238"),fit: BoxFit.fill,),
                    Image(image: NetworkImage("https://english.cdn.zeenews.com/sites/default/files/styles/zm_700x400/public/2022/09/19/1092478-5-26.jpg?im=Resize=(1280,720)"),fit: BoxFit.fill,),
                    Image(image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSH809taCOAv9jngh37sy_wqystLtItjhQiGg&usqp=CAU"),fit: BoxFit.fill,),
                  ],)
                )
              ],
            ),
          )),


        ],
      ),
    );
  }
}
