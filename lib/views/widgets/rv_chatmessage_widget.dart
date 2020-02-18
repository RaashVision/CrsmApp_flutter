
import 'package:ESmile/viewmodels/rv_chatmessage_viewmodel.dart';
import 'package:ESmile/views/core/base_view.dart';
import 'package:ESmile/views/widgets/rv_uploadimage_widget.dart';
import 'package:emoji_picker/emoji_picker.dart';
//import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

class RVChatMessageWidget extends StatefulWidget {
  @override
  _RVMessageWidgetState createState() => _RVMessageWidgetState();
}

class _RVMessageWidgetState extends State<RVChatMessageWidget> {

  bool isfocus = false;
  bool keyboardvisibility  = false;
  TextEditingControllerWorkaroud _messagecontroller = new TextEditingControllerWorkaroud();
  FocusNode _focus = new FocusNode();
  bool isSticker = false;
  @override
  void initState() {
    // TODO: implement initState
        KeyboardVisibilityNotification().addNewListener(
          onChange: (bool visible) {

            setState(() {
               isfocus = visible;   
            });
           
          },
        );

    super.initState();
   // _focus.addListener(_onFocusChange);

  }


  @override
  Widget build(BuildContext context) {


     return BaseView<RVChatMessageViewModel>(
        onModelReady: (model)=> model.getDefaultData(),
         builder: (context, model, child) =>Container(
        decoration: BoxDecoration(
                  color: Colors.white,
                      boxShadow: [BoxShadow(
                        color: Colors.grey,
                        blurRadius: 1.0,
                      ),]
                     ),

        child: fullView(model)
      
    ));


 
    
  }


  Widget fullView(RVChatMessageViewModel viewmodel){

    return logicToChangeUi()? afterFocus(viewmodel) : beforeFocus(viewmodel);
  }


  Widget beforeFocus(RVChatMessageViewModel viewmodel){
           return Column(
             mainAxisSize: MainAxisSize.min,
             children: <Widget>[
                Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded( child: GestureDetector(onTap: (){
                    setState(() { 
                       isfocus = true; 
                       isSticker = false;
                    })
                    
                    ;},
                  child: Container( height: 60, color: Colors.white, child: Text(_messagecontroller.text??"-"),))
                  ,flex: 6,),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[

                        Flexible(child: IconButton(icon: Icon(SimpleLineIcons.camera),)),
                        Flexible(child: IconButton(icon: Icon(SimpleLineIcons.picture),)),
                        Flexible(child: IconButton(icon: Icon(SimpleLineIcons.docs),)),

                      ],
                    )
                  ,flex: 4,)
                  
                ],
              ),
             ],                      
           );
  
    }

  Widget afterFocus(RVChatMessageViewModel viewmodel){
      
      return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
             // Flexible(child:
               TextField(
                style: TextStyle(fontSize: 20),
                expands: false,
                maxLines: 5,
                minLines: 1,
                    autofocus: isfocus,
                    controller: _messagecontroller,
                    //focusNode: _focus,
                       onTap: (){
                         setState(() {          
                            isfocus = true;
                            isSticker = false;
                         });
                       },
                  ),

             viewmodel.imagelist.length > 0?
                Container(
                  height:70,
                  child: 

                  new ListView.builder
                  (
                    itemCount: viewmodel.imagelist.length,
                    scrollDirection :Axis.horizontal,
                    itemBuilder: (BuildContext ctxt, int index) => RVUploadImageWidget(image:viewmodel.imagelist[index]),

                  )
                
                  // ListView(
                  //    scrollDirection :Axis.horizontal,
                  //    shrinkWrap: true,
                  //   children: <Widget>[
                  //     RVUploadImageWidget(),
                  //     RVUploadImageWidget()
                  //   ],
                  // ),





                ) : Container(),
                 // ),
              Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                 Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Flexible(child: IconButton(icon: Icon(SimpleLineIcons.emotsmile),onPressed: (){

                          // FocusScope.of(context).unfocus();
                           SystemChannels.textInput.invokeMethod('TextInput.hide');
                         //  setState(() {

                            //  if(_messagecontroller.text.length == 0){
                            //    isSticker = !isSticker;

                            //    if(isSticker ==false){
                            //      SystemChannels.textInput.invokeMethod('TextInput.show');
                            //    }
                            //  }
                            //  else{
                                isSticker  = !isSticker;

                                 if(isSticker ==false){
                                 SystemChannels.textInput.invokeMethod('TextInput.show');
                               }
                            // }
                             
                             
                          // });

                      },)),
                      Flexible(child: IconButton(icon: Text('@',style: TextStyle(fontSize: 23 ,color: Colors.grey),),)),
                      Flexible(child: IconButton(icon: Text('Aa',style: TextStyle(fontSize: 23 ,color: Colors.grey),),)),
                    ],
                  )
                ,flex: 4,),
                Expanded(child: Container(),flex: 2,),
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[

                         Flexible(child: IconButton(icon: Icon(SimpleLineIcons.camera),onPressed: (){viewmodel.OpenCameraAndSavetoList();},)),
                        Flexible(child: IconButton(icon: Icon(SimpleLineIcons.picture),)),
                        Flexible(child: IconButton(icon: Icon(SimpleLineIcons.docs),)),
                        Flexible(child: IconButton(icon: Icon(Icons.send),)),

                    ],
                  )
                ,flex: 4,)
                
              ],
            )

              ,isSticker?buildSticker(): Container()

          ],
        );
   //   );
    }

  bool logicToChangeUi(){
    //If text is zero
    if(_messagecontroller.text.length == 0){

      //If keyboard is open
      if(isfocus){
        return true;
      }
      else if(isSticker){
        return true;
      }
      //If keyboard is close
      else{
        return false;
      }
    }
    //If text is not zero
    else if(_messagecontroller.text.length >0){
        return true;
    }
    else{
      return false;
    }
    
  }

  Widget buildSticker(){
    return   EmojiPicker(
      rows: 4,
     // columns: 7,
      //recommendKeywords: ["racing", "horse"],
      numRecommended: 10,
      onEmojiSelected: (emoji, category) {
        print(emoji);
       // setState(() {

               // _messagecontroller.text = _messagecontroller.text +emoji.emoji;   

               int currentPosition = _messagecontroller.selection.start; 

                var oldtext = _messagecontroller.text;
                var newtext = oldtext.substring(0,currentPosition)+emoji.emoji+oldtext.substring(currentPosition,oldtext.length);

                if(currentPosition == oldtext.length)
                   _messagecontroller.setTextAndPosition(newtext);
                else
                   _messagecontroller.setTextAndPosition(newtext,caretPosition: currentPosition+1);
       // });
      },
  );
  
  }




}

    class TextEditingControllerWorkaroud extends TextEditingController {
      TextEditingControllerWorkaroud({String text}) : super(text: text);
    
      void setTextAndPosition(String newText, {int caretPosition}) {
        int offset = caretPosition != null ? caretPosition : newText.length;
        value = value.copyWith(
            text: newText,
            selection: TextSelection.collapsed(offset: offset),
            composing: TextRange.empty);
      }    
    }