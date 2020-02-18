import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RVCircleIconButton extends StatelessWidget {

  final Icon icon;
  final VoidCallback clickCallback;
  final double radius;
  final double imgsize;

  RVCircleIconButton({this.icon,this.clickCallback,this.radius = 10,this.imgsize =200.0});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        backgroundColor: Colors.white,
        radius: radius,
        child:  CircleAvatar(
          backgroundColor: Colors.black,
          radius: radius - 2.0,
          child: Material(
        elevation: 4.0,
        shape: CircleBorder(),
        clipBehavior: Clip.hardEdge,
        color: Colors.transparent,
        child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.black.withOpacity(0.30),
            child: icon,
            onTap: () {
              clickCallback();
            },
          ),
            ),
        )
    );
  }
}