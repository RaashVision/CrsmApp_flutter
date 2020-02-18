
import 'package:ESmile/enums/viewstate.dart';
import 'package:ESmile/interfaces/i_datetimeutil.dart';
import 'package:ESmile/interfaces/i_messagebroker.dart';
import 'package:ESmile/interfaces/i_repository.dart';
import 'package:ESmile/managers/stream_manager.dart';
import 'package:ESmile/models/es_todo_model.dart';
import 'package:ESmile/services/navigation_service.dart';
import 'package:ESmile/services/rabbitmq_service.dart';
import 'package:ESmile/viewmodels/core/base_viewmodel.dart';


import '../locator.dart';

class ESAddUpdateTodoViewModel extends BaseViewModel{

   IRepository iRepository = locator<IRepository>();
   IDateTimeUtils iDateTimeUtils = locator<IDateTimeUtils>();
   NavigationService _navigationService = locator<NavigationService>();
   StreamManager _streamManager = locator<StreamManager>();

   IMessageBroker _iMessageBroker = locator<IMessageBroker>();

   void getDefaultData() async{


     //Publish to View to update the data
     _streamManager.updatethedata().add(true);
    

   }


    void onSendMessage(String title, String startdatestring, String enddateString) async{

     
      _iMessageBroker.sendMessage(title);





    }





   void onSaveAsync(String title, String startdatestring, String enddateString) async
   {
     try{
     setState(viewState: ViewState.Busy);

    //Comvert string to dateime
    var startdate_indatetime = iDateTimeUtils.ConvertStringToDateTime(startdatestring);
    var enddate_indatetime = iDateTimeUtils.ConvertStringToDateTime(enddateString);


     var result = await iRepository.insertTodoRepo(new ESTodoModel(title: title,startdate: startdate_indatetime,enddate: enddate_indatetime,isCompleted: false ));

    if(result.stateStatus == ViewState.Idle){


      //Check db added or not
      var data =await  iRepository.getAllESTodoListRepo();

      var converteddata = data.resultdata as List<ESTodoModel>;

      if(converteddata != null || converteddata.length >0){

    
      }

      //Add flushbar

      //Then go back
      _navigationService.goBack();
    }

     setState(viewState: ViewState.Idle);

     }
     catch(e){
       setState(viewState: ViewState.Idle);
     }
   }


    //Update the database based ion id
    void onUpdateAsync(ESTodoModel olddata,String title, String startdatestring, String enddateString) async{

    try{
     setState(viewState: ViewState.Busy);

    //Comvert string to dateime
    var startdate_indatetime = iDateTimeUtils.ConvertStringToDateTime(startdatestring);
    var enddate_indatetime = iDateTimeUtils.ConvertStringToDateTime(enddateString);

    //Add new data to a=old data
    olddata.title = title;
    olddata.startdate = startdate_indatetime;
    olddata.enddate  = enddate_indatetime;


     var result = await iRepository.updateTodoRepo(olddata);

    //If result is success
    if(result.stateStatus == ViewState.Idle){

      //Add flushbar

      //Then go back to previous page
      _navigationService.goBack();
    }
    //Refresh the UI
     setState(viewState: result.stateStatus);

     }
     catch(e){
       setState(viewState: ViewState.Error);
     }

    }






}