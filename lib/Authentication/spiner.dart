import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Spiner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child:LoadingAnimationWidget.discreteCircle(
          color:Colors.white,
          size: 80,
        ),
      ),
    );
  }
}
