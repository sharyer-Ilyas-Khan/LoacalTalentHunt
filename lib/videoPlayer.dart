import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:playerprofile/Authentication/spiner.dart';
import 'package:video_player/video_player.dart';
class VideoPlayersForUpload extends StatefulWidget {
  final file;
  final id;
  final type;
  const VideoPlayersForUpload({Key? key,this.file,this.id,this.type }) : super(key: key);

  @override
  State<VideoPlayersForUpload> createState() => _VideoPlayersForUploadState();
}

class _VideoPlayersForUploadState extends State<VideoPlayersForUpload> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.file.path))
      ..initialize(
      ).then((_) {
        _controller.setLooping(true);
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _controller.play();
        });
      });
  }
  bool load=false;
  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return load?Spiner():Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Video Player"),
        actions: [
          ElevatedButton(onPressed: (){
            setState(() {
              load=true;
              _controller.pause();
            });
            updateData();
          }, child: Text("Upload"))
        ],
      ),
      body:  Stack(
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
    )

    );
  }
  Future<void> updateData() async {
    int random=DateTime.now().microsecond;
    var ref="$random";
    var imageRef= FirebaseStorage.instance.ref(ref);
    var task=await imageRef.putFile(widget.file);
    var videoUrl=await task.ref.getDownloadURL();
    if(widget.type=="club"){
      await FirebaseFirestore.instance.collection("clubs").doc(widget.id).update({
        "VideoUrl":videoUrl,


      }).whenComplete(() => Navigator.pop(context));

    }else{
      await FirebaseFirestore.instance.collection("Players").doc(widget.id).update({
        "VideoUrl":videoUrl,


      }).whenComplete(() => Navigator.pop(context));

    }

  }
}
