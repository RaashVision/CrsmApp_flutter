import 'package:ESmile/constants/route_paths.dart';
import 'package:ESmile/constants/titles.dart';
import 'package:ESmile/core/dynamic_ui_for_state.dart';
import 'package:ESmile/interfaces/i_validator.dart';
import 'package:ESmile/managers/stream_manager.dart';
import 'package:ESmile/models/es_todo_model.dart';
import 'package:ESmile/viewmodels/es_addupdatetodo_viewmodel.dart';
import 'package:ESmile/views/core/base_view.dart';
import 'package:ESmile/views/shared/app_colors.dart';
import 'package:ESmile/views/shared/style.dart';
import 'package:ESmile/views/widgets/es_rectangle_btn.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../locator.dart';

/*
Widget to Add and Update the Todo LIST. Merge  the add and update together so that easy to use and handle . Both of of them have same ui too
.Not recommended to use same u for the ADD and Update. Violate the SingleResposiblity function. (Maybe im wrong)

 */


class ESAddUpdateTodoView extends StatefulWidget {

  ESTodoModel esTodoModel;
  bool isAdd ;
  

  ESAddUpdateTodoView({this.esTodoModel});

  @override
  _ESState createState() => _ESState();
}

class _ESState extends State<ESAddUpdateTodoView> {


//Initiliazation
  final _formKey = GlobalKey<FormState>();
  IValidator ivalidator = locator<IValidator>();
   TextEditingController _titleController = new TextEditingController();
   TextEditingController _dateofstartController = new TextEditingController();
   TextEditingController _dateofendController = new TextEditingController();
  final format = DateFormat("dd-MM-yyyy");
  Size screenSize;
  DateTime startDateInit = DateTime.now();

  //Needed to update the page. Use RXDart
 StreamManager _streamManager = locator<StreamManager>();

  @override
  void initState() {

      //Received publish data from publisher. This is subcriber
      _streamManager.updatethedata().stream.listen((value)=>{

          //If got data, then populate the data
          populateDataForUpdate()
      });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    //As indication for the page that this is add page or update. Its no recommended to use add and update at same page. Violate SingleResponsiblePrinciple
    // But due to time limitation have to
    widget.isAdd = widget.esTodoModel == null ? true : false;

    screenSize = MediaQuery.of(context).size;
     return BaseView<ESAddUpdateTodoViewModel>(
        onModelReady: (model)=> model.getDefaultData(),
         builder: (context, model, child) => DynamicUIBasedOnState(state:model.state, onMAinUI: fullView(model),)
      
    );
  }


  Widget fullView(ESAddUpdateTodoViewModel viewModel){
    return Scaffold(
       appBar: AppBar(title: Text(widget.isAdd?AddAppBarTitle :UpdateAppBarTitle),),
          body: Form(
                  key: _formKey,
                  //autovalidate: true,
                child: SafeArea(
              child:  Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: new ListView
                        (
                          shrinkWrap: true,
                          children: <Widget>[
                            
                            SizedBox(height: 20,),
                            todoTitleWidget(),
                            genericdateWidget("Start Date",_dateofstartController,true),
                            SizedBox(height: 10,),
                            genericdateWidget("Estimated End Date",_dateofendController,false),

                          ],
                         
                        ),
                  ),

                      Align(
                        alignment: Alignment.bottomCenter,
      
                          child: ESRectangleBtn(height: 50,width: screenSize.width,title: widget.isAdd? AddBtnTitle :UpdateBtnTitle,callback: () async=>{

                               OnSave(viewModel)

                          },)
                        ),
                      
                ],
              ),
 
            ),
          )
          
          
          );

    
  }



  void OnSave(ESAddUpdateTodoViewModel viewModel) async{
    
     final _form = _formKey.currentState;

     if(_form.validate()){

        _form.save();

        //IF Add page Inser to database
        if(widget.isAdd){
            viewModel.onSendMessage(_titleController.value.text,_dateofstartController.value.text, _dateofendController.value.text);
        }
        //Else update the datanbase
        else{
             viewModel.onUpdateAsync(widget.esTodoModel,_titleController.value.text,_dateofstartController.value.text, _dateofendController.value.text);
        }

     }


  }

  Widget todoTitleWidget(){

    return Container(
      height: 200,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[

          Flexible(child: Text(AddHeaderTitle,style: TodoHeaderstyle,),flex: 2,),
          SizedBox(height: 10,),
          Expanded(
            child: TextFormField(
              controller: _titleController,
              keyboardType: TextInputType.multiline,
              maxLines: 7,
              validator: (value){
                return ivalidator.validatorTitle(value);
              },
              decoration: new InputDecoration(
                // focusedBorder: OutlineInputBorder(
                //   borderSide: BorderSide(color: Colors.black, width: 5.0),
                // ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2.0),
                ),
                 focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
                hintText: AddTodoTextfieldHint),
            ),
          flex: 8,)

        ],
      )
    );

  }

  Widget genericdateWidget(String header,TextEditingController _controller,bool isStart){

     return Container(
      height: 100,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[

          Flexible(child: Text(header,style: TodoHeaderstyle,),flex: 2,),
          SizedBox(height: 10,),
          Expanded(
            child: DateTimeField(
                   //autovalidate: true,
                   //keyboardAppearance: Brightness.light,
                   controller:_controller ,
                   validator: (value){
                      return ivalidator.validatorDate(value);
                    },
                    
                  format: format,
                  onShowPicker: (context, currentValue) {

                    if(isStart){

                       return showDatePicker(
                        context: context,
                        firstDate: isStart? DateTime.now() : startDateInit,
                        initialDate: isStart? currentValue ?? DateTime.now() :startDateInit,
                        lastDate: DateTime(2100));

                    }
                    else{
                      if(_dateofstartController.value.text.isNotEmpty){

                        return showDatePicker(
                        context: context,
                        firstDate: isStart? DateTime.now() : startDateInit,
                        initialDate: isStart? currentValue ?? DateTime.now() :startDateInit,
                        lastDate: DateTime(2100));
                      }
                    }            
                  },
                  
                  onChanged: (value){

                    if(isStart){
                     // if(value == null){
                       // setState(() {
                            _dateofendController.text =  "";
                        //});

                    //  }
                      startDateInit = value;

                    }
                        
                  },
                  decoration: new InputDecoration(
                // focusedBorder: OutlineInputBorder(
                //   borderSide: BorderSide(color: Colors.black, width: 5.0),
                // ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
                 focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
                //suffixIcon: _controller.value.text.isEmpty ? (Icons.arrow_drop_down) : Icon(Icons.ac_unit)
                ),
                ),
          flex: 8,)

        ],
      )
    );

  }


  void populateDataForUpdate(){
        //If got data, then populate the data
    if(!widget.isAdd){
      _titleController.text = widget.esTodoModel.title;
      _dateofstartController.text = DateFormat("dd-MM-yyyy").format(widget.esTodoModel.startdate);
      _dateofendController.text = DateFormat("dd-MM-yyyy").format(widget.esTodoModel.enddate);
    }
  }





}