import 'package:CrResposiveApp/core/base_model_widget.dart';
import 'package:CrResposiveApp/core/dynamic_ui_for_state.dart';
import 'package:CrResposiveApp/viewmodels/cr_home_viewmodel.dart';
import 'package:CrResposiveApp/views/core/base_view.dart';
import 'package:CrResposiveApp/views/pages/cr_detail_view/cr_detail_view.dart';
import 'package:CrResposiveApp/views/pages/cr_home_view/cr_home_shimmer.dart';
import 'package:CrResposiveApp/views/widgets/cr_typicon_widget.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:CrResposiveApp/constants/route_paths.dart' as routes;

class CrHomeViewMobileLandscape extends BaseModelWidget<CRHomeViewModel>  {
 
  List<bool> isSelected = [false, false, false];
 BuildContext maincontext;

  @override
  Widget build(BuildContext context, CRHomeViewModel model) {
    maincontext = context;
     return DynamicUIBasedOnState(state:model.state, onMAinUI: fullView(model),onInitUI: CRHomeLoadingShimmer(numOfColuminGrid: 5,),onLoadingUI: CRHomeLoadingShimmer(numOfColuminGrid: 5,),);
  }


  Widget fullView(CRHomeViewModel model){

    return Scaffold(
      appBar: AppBar(title: Text(routes.appBarTiitle),centerTitle: true,),
          body: SafeArea(
         child: Padding(
           padding: const EdgeInsets.fromLTRB(20,10,20,0),
           child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        //mainAxisSize: MainAxisSize.max,
        children: <Widget>[
              Center(
                            child: ToggleButtons(
                      children: <Widget>[
                        Text("1"),
                        Text("2")
                     
                      ],
                      isSelected: model.isSelected,
                      onPressed: (int index) {
                        
                        model.updatetoggleBtn(index);
                      },
                    ),
              ),
              SizedBox(),

              Flexible(
                  child: GridView.count(
                  crossAxisCount: 5,
                  shrinkWrap: true,
                  //scrollDirection: Axis.horizontal,
                  children: List.generate(model.listofdata.length, (index) {
                      return  Container( 
                       // height: 60,
                        child: GestureDetector(
                          onTap: (){


                            Alert(context: maincontext,title:"Detail",buttons: [], content:Container(height: 200, width: 300, child: CrDetailView(data: model.listofdata[index],)) ).show();

                          },
                          
                          child: CRTypiconCardWidget(data: model.listofdata[index],)));
                    
                  }
            ),
                ),
              )


        ],
      ),
         ),
          ),
    );
  }
}