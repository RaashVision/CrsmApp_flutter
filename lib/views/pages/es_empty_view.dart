import 'package:CrResposiveApp/views/shared/style.dart';
import 'package:flutter/cupertino.dart';

/* This is the widget to show emppy page. Make it separate so that easy to change and use across the app */

class ESEmptyStateView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
             shrinkWrap: true,
             children: <Widget>[

               Image.asset(
                      "empty.png",
                      height: MediaQuery
                                .of(context)
                                .size
                                .height /2,
                      width:MediaQuery
                            .of(context)
                            .size
                            .width,
                    ),
                    Text("Todo List is Empty..",textAlign: TextAlign.center,style: TodoTilestyle,)



             ],
           );
  }
}