import 'package:CrResposiveApp/models/typicode_photo.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CRTypiconCardWidget extends StatelessWidget {

  final TypiCodePhoto data;
  final bool isLoading ;
  

  CRTypiconCardWidget({this.data,this.isLoading = false});

  @override
  Widget build(BuildContext context) {

 //Show realUi
    if(!isLoading){

       return Hero(
                tag: "ColorDetail"+data.id.toString(),
                child: Container(    
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
   
          ),
       );

    }
    //show loading ui
    else{

      return Container(    
        //color: Colors.green,
          padding: EdgeInsets.all(10),   
            child: Center(
              child:         
            Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              enabled: true,
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(child:  Container(
                                        width: double.infinity,
                                        //height: 8.0,
                                        height: 10,
                                        color: Colors.red,
                                      ),
                        flex: 8,),
                    Flexible(child:  Container(
                                        width: double.infinity,
                                       // height: 8.0,
                                       height: 20,
                                        color: Colors.blue,
                                      ),flex: 2,),
              ]
          ),
            ),
          )
   
        );
      
     }
    
       
  }
}