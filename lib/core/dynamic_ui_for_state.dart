import 'package:CrResposiveApp/views/pages/es_empty_view.dart';
import 'package:CrResposiveApp/views/pages/es_error_view.dart';
import 'package:CrResposiveApp/views/shared/style.dart';
import 'package:flutter/material.dart';
import 'package:CrResposiveApp/enums/viewstate.dart';

class DynamicUIBasedOnState extends StatefulWidget {

   Widget onLoadingUI;
   Widget onMAinUI;
   Widget onInitUI;
   ViewState state;
   VoidCallback onRetry;

  DynamicUIBasedOnState({this.state,this.onLoadingUI :const CircularProgressIndicator(),this.onMAinUI,this.onInitUI :const CircularProgressIndicator(),this.onRetry});

  @override
  _DynamicUIBasedOnStateState createState() => _DynamicUIBasedOnStateState();
}

class _DynamicUIBasedOnStateState extends State<DynamicUIBasedOnState> {



  @override
  void initState() {

    super.initState();

  }
  @override
  Widget build(BuildContext context) {

      Widget currentUI = defaultLoadingUI(Colors.green);

      switch(widget.state){

        case ViewState.Initialization:{
          currentUI = widget.onInitUI;
          break;
        }
        case ViewState.Idle:
          currentUI = widget.onMAinUI;
          break;
        case ViewState.Busy:
          currentUI = Stack(children: <Widget>[     
            widget.onMAinUI,
             //Container(color: Colors.black.withOpacity(2.0),)
           
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(child: Container(color: Colors.black.withOpacity(0.9)))
                
              ],
            ),

             Center(child: widget.onLoadingUI),

          ]);
          break;
        case ViewState.Error:
        {
          currentUI = ESErrorView(onRetry: widget.onRetry,);
          break;
        }
        case ViewState.NoData:
        {
           currentUI = ESEmptyStateView();
           

         
          break;
        }
        case ViewState.NoInternet:
        {
           currentUI = Stack(children: <Widget>[     
            widget.onMAinUI,
          Align(alignment: Alignment.topLeft, child: Container(width: MediaQuery.of(context).size.width,child: Text('No internet'),),),

          ]);
          break;
        }
        default:
          currentUI = Container();
          break;
      }
      return currentUI == null ? defaultLoadingUI(Colors.yellow) : currentUI;
  }


   Widget defaultLoadingUI(Color color){

    return Center(
      child: CircularProgressIndicator(backgroundColor: color,),
    );
  }
}