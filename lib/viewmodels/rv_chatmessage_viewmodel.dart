
import 'dart:typed_data';

import 'package:ESmile/enums/viewstate.dart';
import 'package:ESmile/interfaces/i_camera.dart';
import 'package:ESmile/locator.dart';
import 'package:ESmile/viewmodels/core/base_viewmodel.dart';

class RVChatMessageViewModel extends BaseViewModel{

  ICameraService cameraService = locator<ICameraService>();
  List<Uint8List> imagelist = new List<Uint8List>();

//Nothing to load at starting of page
   void getDefaultData() async{

    

   }




   void OpenCameraAndSavetoList() async{

     var image = await cameraService.getImageFromCameraByte();

     imagelist.add(image.resultdata);


     setState(viewState: ViewState.Idle);

   }
}