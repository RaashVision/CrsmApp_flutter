import 'package:CrResposiveApp/enums/viewstate.dart';
import 'package:CrResposiveApp/interfaces/i_api.dart';
import 'package:CrResposiveApp/interfaces/i_repository.dart';
import 'package:CrResposiveApp/locator.dart';
import 'package:CrResposiveApp/managers/stream_manager.dart';
import 'package:CrResposiveApp/models/es_todo_model.dart';
import 'package:CrResposiveApp/models/result.dart';

class Repository implements IRepository{

    IApi  iapi = locator<IApi>();


  @override
  Future<ResultAndStatus> gettypicodephotosbyIdRepo(int albumId) async{
     try{

      var data =  await iapi.gettypicodephotosbyId(albumId);
      return data;
    }
    catch(e){
        return ResultAndStatus(ViewState.Error, e.toString(), null);
    }
  }




}

