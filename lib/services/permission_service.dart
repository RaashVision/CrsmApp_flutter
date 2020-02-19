import 'dart:io';
import 'package:CrResposiveApp/services/dialog_service.dart';
import 'package:permission_handler/permission_handler.dart';

import '../locator.dart';

class PermissionService{

    final PermissionHandler _permissionHandler = PermissionHandler();

//Request for the permission
   Future<bool> requestPermission(PermissionGroup permission) async {
   var result = await _permissionHandler.requestPermissions([permission]);

      //IOS have some different behaviour then android so handle different
        if(Platform.isIOS){
          if (result[permission] == PermissionStatus.granted) {
            return true;
          }
          if (result[permission] == PermissionStatus.denied) {

            DialogService _dialogService = locator<DialogService>();

            var dialogResult = await _dialogService.showDialog(
              title: 'Permission required',
              description: 'Please give all the permission need',
              buttonTitle: "Open App Settings"
            );
            if (dialogResult.confirmed) {
              await _permissionHandler.openAppSettings();

            } else {
            }
            return false;
          }

        }
      //Android have different way to handle
        if(Platform.isAndroid) {
          if (result[permission] == PermissionStatus.granted) {
            return true;
          }
          else if (result[permission]== PermissionStatus.unknown){
            return true;
          }
        }
        return false;
      }

//Check particular have permission or not
 Future<bool> hasPermission(PermissionGroup permission) async {
   var permissionStatus =
   await _permissionHandler.checkPermissionStatus(permission);
   return permissionStatus == PermissionStatus.granted;
 }



}