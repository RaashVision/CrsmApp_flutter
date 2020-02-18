import 'package:ESmile/core/base_model_widget.dart';
import 'package:ESmile/core/dynamic_ui_for_state.dart';
import 'package:ESmile/viewmodels/cr_home_viewmodel.dart';
import 'package:ESmile/views/core/base_view.dart';
import 'package:ESmile/views/widgets/cr_typicon_widget.dart';
import 'package:flutter/material.dart';

class CrHomeViewMobileLandscape extends BaseModelWidget<CRHomeViewModel>  {
 
  List<bool> isSelected = [false, false, false];


  @override
  Widget build(BuildContext context, CRHomeViewModel model) {
     return DynamicUIBasedOnState(state:model.state, onMAinUI: fullView(model),);
  }


  Widget fullView(CRHomeViewModel model){

    return Scaffold(
      appBar: AppBar(),
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
                        child: CRTypiconCardWidget(data: model.listofdata[index],));
                    
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