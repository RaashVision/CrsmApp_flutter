

import 'dart:async';

import 'package:flushbar/flushbar.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:CrResposiveApp/enums/viewstate.dart';
import 'package:CrResposiveApp/viewmodels/core/base_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../locator.dart';

/*
BaseModel for the view to handle. Make it base to prevent duplicate code accross page
 */

class BaseView<T extends BaseViewModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget child) builder;
  final Function(T) onModelReady;
  final Function(BuildContext context, T model, dynamic event) onErrorOccured;
  final Widget child;

  BaseView({this.builder, this.onModelReady,this.onErrorOccured,this.child});

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> {
  T model = locator<T>();
  StreamSubscription<dynamic> erroreventSubscription;
  @override
  void initState() {
    if (widget.onModelReady != null) {
      widget.onModelReady(model);
    }

    //error
    erroreventSubscription = model.onErrorOccur?.listen(onEventOccured);

    model.state;
    
    super.initState();
  }

  void onEventOccured(dynamic event) {

    if (widget.onErrorOccured != null && mounted) {
      widget.onErrorOccured(context, model, event);
     setState(() {});
    }

  }

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<T>(
        create: (context) => model,
        child: Consumer<T>(builder: widget.builder));
        // child:  widget.child,);
  }

   @override
  void dispose() {
    erroreventSubscription?.cancel();
    super.dispose();
  }



  







}