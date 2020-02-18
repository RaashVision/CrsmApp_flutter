import 'dart:ffi';
import 'dart:typed_data';
import 'package:ESmile/interfaces/i_camera.dart';
import 'package:ESmile/models/service_result.dart';
import 'package:ESmile/services/permission_service.dart';
import 'package:ESmile/utils/converter_utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

import '../locator.dart';
class ImagePickerCameraService implements ICameraService {

ConverterHelperUtils _converter;
PermissionService _permissionService;

//Contructor
  ImagePickerCameraService(PermissionService permissionService ,ConverterHelperUtils converter)
  {
      _converter = converter??locator<ConverterHelperUtils>();
      _permissionService = permissionService??locator<PermissionService>();
  }

  @override
  Future<ServiceResultAndStatus> getImageFromCameraByte() async {

    ServiceResultAndStatus result;

//Permission portion TODO need imporvement
    bool ispermissiongiven = false;

    if(!await _permissionService.hasPermission(PermissionGroup.camera)){
        ispermissiongiven = await _permissionService.requestPermission(PermissionGroup.camera);
    }
    else{
      ispermissiongiven = true;
    }

    //If permission is denied
    if(!ispermissiongiven){

      result = new ServiceResultAndStatus(false, "Permission denied", null);
      return   result;
    }



    //Added small image size because sometime throw erro for low spec phone
   var image = await ImagePicker.pickImage(source: ImageSource.camera,maxHeight: 480, maxWidth: 640);

    if(image == null){
      
      if(Platform.isAndroid){

        //Handling MainActivity destruction on Android #
        LostDataResponse response = await ImagePicker.retrieveLostData();

        //Get data from loss storage
        image = response.file;
      }
      
   // return await response.file;
    }

    var imageinbyte = _converter.convertListintToUint8List(image.readAsBytesSync());

    result = new ServiceResultAndStatus(true, "Success", imageinbyte);
    return result;
  }

  

  // @override
  // Future<File> getImageFromCameraFile() {
  //   // TODO: implement getImageFromCameraFile
  //   return null;
  // }


  
}