import 'package:ESmile/models/es_todo_model.dart';
import 'package:ESmile/viewmodels/es_timeleft_viewmodel.dart';
import 'package:ESmile/viewmodels/es_todo_viewmodel.dart';
import 'package:ESmile/views/shared/style.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:ESmile/views/core/base_view.dart';
import 'package:ESmile/constants/route_paths.dart' as routes;
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../shared/app_colors.dart';
import 'es_timeleft_widget.dart';

/*
  Widget for the List Item. Make it separate so that its reusable

 */

class ESTodoWidget extends StatefulWidget {

  double height;
  ESTodoModel esTodoModel;
  bool isExpired;

  ESTodoWidget({this.height=160,this.esTodoModel});

  @override
  _ESTodoWidgetState createState() => _ESTodoWidgetState();
}

class _ESTodoWidgetState extends State<ESTodoWidget> {


 // bool timeDilation = widget.esTodoModel.isCompleted;
   final GlobalKey<ScaffoldState> _flushbarkey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BaseView<ESTodoViewModel>(
        onModelReady: (model)=> model.getDefaultData(),
        //onErrorOccured:onEventOccured,
        builder: (context, model, child) =>  

               Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                    boxShadow: [BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0,
                    ),]
                   ),
                height: widget.height,  
                child: 
                MaterialButton(
                  padding: EdgeInsets.all(0),
                  disabledColor : Colors.black.withOpacity(0.5),
                  onPressed:DateTime.now().isAfter(widget.esTodoModel.enddate)? null: (){

                     model.navigationService.navigateTo(routes.AddTodoRoute,arguments:widget.esTodoModel);

                  },
                  color: Colors.white,
                  shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.transparent)),
                      child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15.0,8,15.0,0),
                          child: Container(color: Colors.transparent, child: Align(alignment: Alignment.centerLeft, child: SingleChildScrollView(scrollDirection: Axis.horizontal,child: Text(widget.esTodoModel.title??"Error",style: TodoTilestyle,)))),
                        )                  
                      ,flex:4),
                      //SizedBox(),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15.0,0,15.0,0),
                          child: middleUi(),
                        )
                      ,flex: 3,),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0.0,0,0,0),
                          child: bottomUi(model),
                        ),
                      flex:3)
                      


                    ],
                    
                  ),
                       //         ),
                ),
          ),
            //),
      //  )
      
    );
  }


Widget middleUi(){

  return Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[

      Expanded(child: genericCol("Start Date", (DateFormat('d MMM d, ''yyyy').format(widget.esTodoModel.startdate)).toString()??"Error",CrossAxisAlignment.start),),
      Expanded(child: genericCol("End Date",(DateFormat('d MMM, ''yyyy').format(widget.esTodoModel.enddate)).toString()??"Error",CrossAxisAlignment.center),),
      Expanded(child: timeLeftWidget("Time Left",CrossAxisAlignment.end))

    ],
  );



}
Widget genericCol(String title,String value,CrossAxisAlignment caligm){

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: caligm,
      children: <Widget>[

          Flexible(child: Text(title,textAlign: TextAlign.start,style: TodoDateTtilestyle,)),
          Expanded(child: Text(value,style: TodoDatestyle,textAlign: TextAlign.start,)),

      ],
    );

}

Widget timeLeftWidget(String title,CrossAxisAlignment caligm){

  return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: caligm,
      children: <Widget>[

          Flexible(child: Text(title,textAlign: TextAlign.start,style: TodoDateTtilestyle,)),
          Expanded(child: ESTimeLeft(esTodoModel:widget.esTodoModel)),

      ],
    );

  

}




Widget bottomUi(ESTodoViewModel viewModel){

  return Container(
     decoration: BoxDecoration(
                color: EQGreyColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)

                ),
              ),
    //color: Colors.grey[100],
    child: Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[

        Expanded(child: Padding(
          padding: const EdgeInsets.fromLTRB(15.0,0,15.0,0),
          child: statusWidget(),
        ),),
        //Expanded(child: statusWidget(),),
        Expanded(child: checkboxWidget(viewModel),)


      ],
    )

  );

}

Widget statusWidget(){

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[

        Text("Status :"),
        Text(widget.esTodoModel.isCompleted ? "Completed" : "InComplete"??"Error")


      ],  

    );
}

Widget checkboxWidget(ESTodoViewModel viewModel){

 // var viewmodel = Provider.of<ESTodoViewModel>(context);

   return Row(
     mainAxisSize: MainAxisSize.min,
     mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Flexible(child: Text("Tick if Complete")),
            Checkbox(
              activeColor: PrimaryColor,
              value: widget.esTodoModel.isCompleted,
              onChanged: (bool newValue) {


                if(DateTime.now().isAfter(widget.esTodoModel.enddate)){
                  return null;
                }

               // Update the iComplete value
                widget.esTodoModel.isCompleted = newValue;

                viewModel.onUpdate(widget.esTodoModel);

                 widget.esTodoModel.isCompleted = newValue;

                // setState(() {
                //   timeDilation = newValue;
                  

                // });
               // onChanged(newValue);
              },
            ),
          ],
        );
    //);
}



}

