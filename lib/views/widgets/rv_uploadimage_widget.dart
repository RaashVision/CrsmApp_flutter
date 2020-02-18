import 'dart:typed_data';

import 'package:ESmile/views/widgets/rv_circleicon_button.dart';
import 'package:flutter/material.dart';

class RVUploadImageWidget extends StatelessWidget {

  final Uint8List image;

  RVUploadImageWidget({this.image});

  @override
  Widget build(BuildContext context) {
    return  Stack(

        children: <Widget>[

        Container(

          height: 60,
          width: 60,
          //color: Colors.blue,
          child: Center(child: imageContainer(image)),
        ),

        
        Positioned(right: 0,top: 0, child: RVCircleIconButton(icon: Icon(Icons.close, size: 10,),))

        ],
        
      );
 //   );
  }

  Widget imageContainer(Uint8List _image){

    return Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(Radius.circular(5)),            
        ),
        child: Image.memory(_image ,fit: BoxFit.fill,) ,
    );

  }





}