
import 'package:ESmile/enums/viewstate.dart';
import 'package:ESmile/interfaces/i_repository.dart';
import 'package:ESmile/models/typicode_photo.dart';
import 'package:ESmile/viewmodels/core/base_viewmodel.dart';

import '../locator.dart';

class CRHomeViewModel extends BaseViewModel{

  //Get list of data from 
  List<TypiCodePhoto> listofdata = List<TypiCodePhoto>();

  String errormessage; 
  IRepository iRepository = locator<IRepository>();

   List<bool> isSelected = [true, false,];


  void getDefaultData() async{

    try{

     setState(viewState: ViewState.Busy);

    var result = await iRepository.gettypicodephotosbyIdRepo(1);
     errormessage = result.errormessage;
    

    if(result.stateStatus == ViewState.Idle){
      
      var data = result.resultdata as List<TypiCodePhoto>;
      if(data.length >0){

        listofdata = data;

        setState(viewState: ViewState.Idle);
      }
      //No data
      else{
          setState(viewState: ViewState.NoData);
      }
    }
    //Got error
    else{

     setState(viewState: ViewState.Error, event: errormessage);

    }

    }
    catch(e){
      setState(viewState: ViewState.Error, event: e.toString());
    }
  }


  void updatetoggleBtn(int index) async{


    try{

    setState(viewState: ViewState.Busy);
    
    for (int indexBtn = 0;indexBtn < isSelected.length;indexBtn++) {
      if (indexBtn == index) {
        isSelected[indexBtn] = !isSelected[indexBtn];
      } else {
        isSelected[indexBtn] = false;
      }
    }

    var result = await iRepository.gettypicodephotosbyIdRepo(index+1);
    errormessage = result.errormessage;
     if(result.stateStatus == ViewState.Idle){
      
      var data = result.resultdata as List<TypiCodePhoto>;
      if(data.length >0){

        listofdata = data;

        setState(viewState: ViewState.Idle);
      }
      //No data
      else{
          setState(viewState: ViewState.NoData);
      }
    }
    //Got error
    else{

     setState(viewState: ViewState.Error, event: errormessage);

    }

    }
    catch(e){

      setState(viewState: ViewState.Error, event: e.toString());

    }


     
  }


}