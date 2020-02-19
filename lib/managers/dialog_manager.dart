
import 'package:CrResposiveApp/models/alert_request.dart';
import 'package:CrResposiveApp/models/alert_response.dart';
import 'package:CrResposiveApp/services/dialog_service.dart';
import 'package:CrResposiveApp/views/shared/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../locator.dart';

class DialogManager extends StatefulWidget {
  final Widget child;
  DialogManager({Key key, this.child}) : super(key: key);

  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  DialogService _dialogService = locator<DialogService>();

  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(_showDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _showDialog(AlertRequest request) {
    Alert(
        context: context,
        title: request.title,
        desc: request.description,
        style: AlertStyle(isCloseButton: false,isOverlayTapDismiss: true),
        closeFunction: () =>
            _dialogService.dialogComplete(AlertResponse(confirmed: false)),
        buttons: [
          DialogButton(
            color: PrimaryColor,
 radius: BorderRadius.circular(5),
            child: Text(request.buttonTitle, style: TextStyle(color: Colors.black),),
            onPressed: () {
              _dialogService.dialogComplete(AlertResponse(confirmed: true));
              Navigator.of(context).pop();
            },
          ),

            DialogButton(
            color: PrimaryColor,
            radius: BorderRadius.circular(5),
            child: Text(request.buttonNegativeTitle, style: TextStyle(color: Colors.black),),
            onPressed: () {
              _dialogService.dialogComplete(AlertResponse(confirmed: false));
              Navigator.of(context).pop();
            },
          )
        ]).show();
  }

}