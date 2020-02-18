import 'package:ESmile/viewmodels/rv_chat_viewmodel.dart';
import 'package:ESmile/views/widgets/rv_chatappbar_widget.dart';
import 'package:ESmile/views/widgets/rv_chatmessage_widget.dart';
import 'package:flutter/material.dart';

import '../../core/dynamic_ui_for_state.dart';
import '../core/base_view.dart';

class RVChatView extends StatefulWidget {
  @override
  _RVChatViewState createState() => _RVChatViewState();
}

class _RVChatViewState extends State<RVChatView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<RVChatViewModel>(
        onModelReady: (model)=> model.getDefaultData(),
         builder: (context, model, child) => DynamicUIBasedOnState(state:model.state, onMAinUI: fullView(model),)
      
    );
  }



  Widget fullView(RVChatViewModel model){

    return SafeArea(
          child: Scaffold(
        appBar:  ChatAppBar(),        
        body: Stack(
          children: <Widget>[
            Container(),
            
            Align(alignment: Alignment.bottomCenter,child: RVChatMessageWidget())
          ],
        ),
      ),
    );
    
  }
}