import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:playerprofile/Authentication/spiner.dart';
import 'package:video_player/video_player.dart';
class VideoPlayersForMedia extends StatefulWidget {
  final url;
  const VideoPlayersForMedia({Key? key,this.url }) : super(key: key);

  @override
  State<VideoPlayersForMedia> createState() => _VideoPlayersForMediaState();
}

class _VideoPlayersForMediaState extends State<VideoPlayersForMedia> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
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
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Video Player"),
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
            ),
          ],
    )

    );
  }
}
