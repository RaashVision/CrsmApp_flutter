import 'package:flutter/cupertino.dart';

/* This is the widget to show error page. Make it separate so that easy to change and use across the app */

class ESErrorView extends StatelessWidget {

  final VoidCallback onRetry;
  final String errormessage;

  ESErrorView({this.onRetry,this.errormessage});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[

          Expanded(
                      child: GestureDetector(
              onTap: (){
                onRetry();
              },
                        child: Image.asset(
                    "error.png",
      
                  ),
            ),
          ) 



        ],
      )),
      
    );
  }
}