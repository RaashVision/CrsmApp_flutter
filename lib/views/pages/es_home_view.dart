import 'package:ESmile/constants/titles.dart';
import 'package:ESmile/core/dynamic_ui_for_state.dart';
import 'package:ESmile/enums/viewstate.dart';
import 'package:ESmile/viewmodels/es_home_viewmodel.dart';
import 'package:ESmile/views/shared/app_colors.dart' as prefix0;
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:ESmile/views/core/base_view.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../constants/route_paths.dart';
import '../shared/app_colors.dart';
import '../widgets/es_todo_widget.dart';
import 'package:ESmile/constants/route_paths.dart' as routes;

/*

This is the main Home page of the app. Its logic is handle by Its vIEWMODEL


 */

class ESHomeView extends StatefulWidget {
  @override
  _ESHomeViewState createState() => _ESHomeViewState();
}

class _ESHomeViewState extends State<ESHomeView> {

 final GlobalKey<ScaffoldState> _flushbarkey = new GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return BaseView<ESHomeViewModel>(
        onModelReady: (model)=> model.getDefaultData(),
        //onErrorOccured:onEventOccured,
        builder: (context, model, child) =>  Scaffold(
          appBar: AppBar(title: Text(HomeAppBarTitle),actions: <Widget>[

              IconButton(onPressed: () async{

                  //Delete all data
                if(model.state == ViewState.Idle)
                   model.deleteALL();


              }, icon: Icon(Icons.delete),color: Colors.black,)

          ],),
          floatingActionButton: FloatingActionButton(
            onPressed: () {

              model.navigationService.navigateTo(routes.ChatRoute);
              
            },
            child: Icon(Icons.add),),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          backgroundColor: HomeBackgroundColor,
          body:RefreshIndicator(
            color: PrimaryColor,
            onRefresh:() async=> model.getDefaultData(),
                      child: DynamicUIBasedOnState(state:model.state, 
            onRetry : ()async{ model.getDefaultData();},
            onMAinUI:  SafeArea(
              child:  new ListView.builder
                  (
                    itemCount: model.listOfESTODOList().length,
                    itemBuilder: (BuildContext ctxt, int index) => Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: 
                       Slidable(
                      actionPane: SlidableBehindActionPane(),
                      actionExtentRatio: 0.25,
                        secondaryActions: <Widget>[

                          IconSlideAction(
                            //caption: 'Delete',
                            color: Colors.transparent,
                            iconWidget: Icon( Icons.delete,size: 45,color:Colors.red ,),
                            onTap: () async => {

                              //No ongoing delete process for other list
                              if(model.deleteprocessonGoing == false){
                                Future.delayed(Duration.zero, () => SnackBarWithButton(model)),
                                model.onDelete(index)
                              }

                            },
                          ),
                        ],
                      child: ESTodoWidget(esTodoModel: model.listOfESTODOList()[index],))
                    )
                  ),
 
         ),),
          )
        )
      
    );
  }





//Todo : Have to make it as separate function so that all can use
void SnackBarWithButton(ESHomeViewModel viewModel) async{

    Flushbar(
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      flushbarPosition: FlushbarPosition.BOTTOM,
      key: _flushbarkey,
      title: "Deleted",
      margin: EdgeInsets.all(8),
      borderRadius: 8,
      message: "Your todo list been deleted",
      icon: Icon(
        Icons.warning,
        size: 28,
        color: PrimaryColor,
      ),
      mainButton: FlatButton(
        onPressed: () async {

         viewModel.onCancelDelete();

        //Cause a black screen bug . Added completedeleted indication to solve this problem temporary
         if(!viewModel.completedDeleted)
            Navigator.pop(context);
        },
        child: Text("UNDO",style: TextStyle(color: Colors.white),),
      ),
      leftBarIndicatorColor: PrimaryColor,
      duration: Duration(seconds:5 ),
    )..show(context);


  }








}