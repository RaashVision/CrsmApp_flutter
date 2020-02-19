
import 'package:CrResposiveApp/models/typicode_photo.dart';
import 'package:CrResposiveApp/services/navigation_service.dart';
import 'package:CrResposiveApp/viewmodels/core/base_viewmodel.dart';

import '../locator.dart';

class CRDetailViewModel extends BaseViewModel{

  TypiCodePhoto data = new TypiCodePhoto();

  NavigationService navigationService = locator<NavigationService>();


  void getDefaultData(TypiCodePhoto data){

    this.data = data;
  }


}