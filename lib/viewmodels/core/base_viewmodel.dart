import 'dart:async';

import 'package:flutter/material.dart';
import 'package:CrResposiveApp/enums/viewstate.dart';
import 'package:CrResposiveApp/locator.dart';

class BaseViewModel extends ChangeNotifier {

  bool _dispose = false;
  ViewState _state = ViewState.Idle;
  //Services services = locator<Services>();

  ViewState get state => _state;

  
  final StreamController<dynamic> erroreventSubscription = StreamController<dynamic>();
  Stream<dynamic> get onErrorOccur => erroreventSubscription.stream;


  void notifyError(dynamic event) {
    erroreventSubscription.sink.add(event);
  }

  void setState({ViewState viewState,dynamic event}) {
    _state = viewState;

    if(_state == ViewState.Error){
      erroreventSubscription.sink.add(event);
    }

    if(_dispose == false)
        notifyListeners();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _dispose = true;
    erroreventSubscription?.close();
  }
}