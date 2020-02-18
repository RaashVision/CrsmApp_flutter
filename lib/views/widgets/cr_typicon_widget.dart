import 'package:ESmile/models/typicode_photo.dart';
import 'package:flutter/material.dart';

class CRTypiconCardWidget extends StatelessWidget {

  final TypiCodePhoto data;

  CRTypiconCardWidget({this.data});

  @override
  Widget build(BuildContext context) {
    
        return Container(    
          padding: EdgeInsets.all(10),   
            child: Center(child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(child: Image.network(
                        data.url,fit:BoxFit.fill ,
                      ),
                      flex: 8,),
                  Flexible(child: Text(data.title, style: TextStyle(fontSize:15),overflow: TextOverflow.ellipsis,),flex: 2,),
            ]
          ),
      )
   
        );
  }
}