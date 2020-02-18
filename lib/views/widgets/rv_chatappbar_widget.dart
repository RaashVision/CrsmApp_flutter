import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget{
  @override
  Widget build(BuildContext context) {
    return  Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black54,
                blurRadius: 3.0,
                offset: Offset(0.0, 0.75)
            )
              
          ],
       // color: colorPrimary
      ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[

              Flexible(child: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){} ),flex: 1,),
              Expanded(child: ListTile(leading: CircleAvatar(backgroundColor: Colors.red,radius: 25,),title: Text("Thiyraash"),subtitle: Text("Online"),),flex: 8,),
              Flexible(child: IconButton(icon: Icon(Icons.info_outline), onPressed: (){} ),flex: 1,),
          ],
        ),
      );
   // );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(70.0);
}