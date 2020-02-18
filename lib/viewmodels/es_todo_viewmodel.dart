import 'package:ESmile/enums/viewstate.dart';
import 'package:ESmile/interfaces/i_repository.dart';
import 'package:ESmile/models/es_todo_model.dart';
import 'package:ESmile/services/navigation_service.dart';
import 'package:ESmile/viewmodels/core/base_viewmodel.dart';

import '../locator.dart';

class ESTodoViewModel extends BaseViewModel{

   NavigationService navigationService = locator<NavigationService>();
   IRepository iRepository = locator<IRepository>();

//Nothing to load at starting of page
   void getDefaultData() async{

    

   }

//This to update the checkbox
   void onUpdate(ESTodoModel esTodoModel) async{

    //Update the datbase with new checkbox value
    var result = await iRepository.updateTodoRepo(esTodoModel);

    setState(viewState:ViewState.Idle);

   }




}