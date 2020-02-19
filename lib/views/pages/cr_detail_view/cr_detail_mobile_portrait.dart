
import 'package:CrResposiveApp/core/base_model_widget.dart';
import 'package:CrResposiveApp/core/dynamic_ui_for_state.dart';
import 'package:CrResposiveApp/viewmodels/cr_detail_viewmodel.dart';
import 'package:CrResposiveApp/viewmodels/cr_home_viewmodel.dart';
import 'package:CrResposiveApp/views/pages/cr_home_view/cr_home_shimmer.dart';
import 'package:flutter/material.dart';

class CrDetailViewMobilePortrait extends BaseModelWidget<CRDetailViewModel>  {
 
  List<bool> isSelected = [false, false, false];


  @override
  Widget build(BuildContext context, CRDetailViewModel model) {
     return DynamicUIBasedOnState(state:model.state, onMAinUI: fullView(model :model),onLoadingUI: CRHomeLoadingShimmer(numOfColuminGrid: 2,),onInitUI: CRHomeLoadingShimmer(numOfColuminGrid: 2,),);
  }


  Widget fullView({CRDetailViewModel model}){

     return Scaffold(
            body: Container(   
              
            padding: EdgeInsets.all(10),   
              child: Hero(
                tag: "ColorDetail"+model.data.id.toString(),
                            child: Center(child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(child: Image.network(
                            model.data.url,fit:BoxFit.fill ,
                          ),
                          flex: 7,),
                      Flexible(child: Text(model.data.title, style: TextStyle(fontSize:15)),flex: 3,),
                ]
            ),
            ),
              )
   
          ),
     );


  }
}
