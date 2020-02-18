
import 'dart:async';

import 'package:ESmile/enums/viewstate.dart';
import 'package:ESmile/interfaces/i_datetimeutil.dart';
import 'package:ESmile/interfaces/i_repository.dart';
import 'package:ESmile/locator.dart';
import 'package:ESmile/managers/stream_manager.dart';
import 'package:ESmile/models/es_todo_model.dart';
import 'package:ESmile/services/dialog_service.dart';
import 'package:ESmile/services/navigation_service.dart';
import 'package:ESmile/viewmodels/core/base_viewmodel.dart';

class ESHomeViewModel extends BaseViewModel{

   IRepository iRepository = locator<IRepository>();
   IDateTimeUtils iDateTimeUtils = locator<IDateTimeUtils>();
   List<ESTodoModel> _listofestodo = new List<ESTodoModel>();
   ESTodoModel deleteditem ;
   int deletedindex;
   NavigationService navigationService = locator<NavigationService>();
   StreamManager iStream = locator<StreamManager>();
   Timer _deletetimer;
   bool completedDeleted = false;
   bool deleteprocessonGoing = false;
   DialogService _dialogService = locator<DialogService>();

   //Contructor for the viewmodel. Contain the stream that refresh even every any db tractaion happens. Like LiveData android
    ESHomeViewModel(){

    //Subcriber for every db change
     iStream.refreshWhenDbHaveChange().stream.listen((value) async{

       //Once received change refresh the page
      refreshPage();

        });

      }
//LOad all the defeault data
   void getDefaultData() async{


     

      //TestData
      var ds = await iRepository.gettypicodephotosbyIdRepo(1);
     



     //Set ui to InitUl
     setState(viewState:ViewState.Initialization);

    //Make database call to get all the data

    var result = await iRepository.getAllESTodoListRepo();

    //if able to complete process without error
    if(result.stateStatus == ViewState.Idle){


      var converteddata = result.resultdata as List<ESTodoModel>;

      //If no data found return NoDataUI
      if(converteddata == null || converteddata.length ==0){

        setState(viewState:ViewState.NoData);
      }
      //If  got data show the main Ui
      else{

        _listofestodo = converteddata;

        setState(viewState: ViewState.Idle);
         
      }

    }
    //If Go Error display error Ui
    else{

      setState(viewState:ViewState.Error);


    }
    

   }

    //The communicator between View and ViewModel
   
   void refreshPage() async{

      //Set ui to InitUl
     setState(viewState:ViewState.Initialization);

    //Make database call to get all the data

    var result = await iRepository.getAllESTodoListRepo();

    //if able to complete process without error
    if(result.stateStatus == ViewState.Idle){


      var converteddata = result.resultdata as List<ESTodoModel>;

      //If no data found return NoDataUI
      if(converteddata == null || converteddata.length ==0){

        setState(viewState:ViewState.NoData);
      }
      //If  got data show the main Ui
      else{

        _listofestodo = converteddata;

        setState(viewState: ViewState.Idle);
         
      }

    }
    //If Go Error display error Ui
    else{

      setState(viewState:ViewState.Error);


    }
    
     
   }
   
   //The data of the list . View access data from this function
   List<ESTodoModel> listOfESTODOList(){

     return _listofestodo;
   }


      //ON Swipe and delete the todo
  void onDelete(int index) async{


      //Indication async process of selete is going on
        deleteprocessonGoing = true;

      //Reset the delete indication
      completedDeleted = false;

      //save the delete item to new variable
      deleteditem = listOfESTODOList()[index];
      deletedindex = index;

      //Removed the deleted item from the list
      listOfESTODOList().removeAt(index);

      //Refrsh the Ui
      setState(viewState: ViewState.Idle);

      //Start the timer to delete, if timer not been cancel , then delete the data
      _deletetimer = Timer(Duration(seconds: 5),()async{

        //Indication that timer has start the deleted process, no point click the UNDO
        completedDeleted = true;

        var result = await iRepository.deleteTodoRepo(deleteditem);


        deleteprocessonGoing = false;
        //If delete is success
        if(result.stateStatus == ViewState.Idle){
          //Clear the delete items and index
          deletedindex = null;
          deleteditem = null;
        }


        //Reset the delete indication
    
      });


   }

  //Cancel the deletion
  void onCancelDelete() async{

    try{
        //Stop the delete timer. Deletion will be cancel
        _deletetimer.cancel();

        //Add back the deleteditem to the list
        if(!listOfESTODOList().contains(deleteditem)){

          listOfESTODOList().insert(deletedindex, deleteditem);

        }
        deleteprocessonGoing = false;
        //Refrsh the Ui
          setState(viewState: ViewState.Idle);
    }
    catch(e){
      
    }
    
  }
   
//Delete all data from the delete icon from the 
  void deleteALL() async{

    try{


      var  dialogResult = await _dialogService.showDialog(
              title: 'Delete All',
              description: "Are you sure you want to delete all the data");

      //If USER CONFIRM DELETE EVERTHING
      if(dialogResult.confirmed){

        setState(viewState:ViewState.Busy);

      var result = await iRepository.deleteallRepo();

      //delete all successfuly
      if(result.stateStatus == ViewState.Idle){

          setState(viewState:ViewState.Idle);
      }
      //delete failed
      else{


          setState(viewState:ViewState.Error);
      }

      }


       

    }
    catch(e){

        setState(viewState:ViewState.Error);

    }

  }


}