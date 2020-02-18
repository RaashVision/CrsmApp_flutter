import 'package:ESmile/constants/titles.dart';
import 'package:ESmile/views/shared/app_colors.dart';
import 'package:ESmile/views/shared/style.dart';
import 'package:flutter/material.dart';
/*
This is the rectangle button for the AddUpdateTODOPage.
Make it separate so that reusable

 */
class ESRectangleBtn extends StatelessWidget {

  final VoidCallback callback;
  final String title;
  final double height;
  final double width;

  ESRectangleBtn({this.title,this.height,this.width,this.callback});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: AddBtnColor,
      onPressed: (){
        callback();
      },
      child: Container(
        height:height,
        width : width,
        child: Align(alignment: Alignment.center,child:new Text(title,style: TodoAddBtnstyle,)),
      ),

      
    );
  }
}