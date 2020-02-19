import 'package:CrResposiveApp/models/typicode_photo.dart';
import 'package:CrResposiveApp/viewmodels/core/base_viewmodel.dart';
import 'package:CrResposiveApp/viewmodels/cr_detail_viewmodel.dart';
import 'package:CrResposiveApp/views/core/base_view.dart';
import 'package:CrResposiveApp/views/responsive/orientation_layout.dart';
import 'package:CrResposiveApp/views/responsive/screen_type_layout.dart';
import 'package:flutter/material.dart';

import 'cr_detail_mobile_landscape.dart';
import 'cr_detail_mobile_portrait.dart';

class CrDetailView extends StatefulWidget {

  TypiCodePhoto data ;

  CrDetailView({this.data});


  @override
  _CrDetailViewState createState() => _CrDetailViewState();
}

class _CrDetailViewState extends State<CrDetailView> {
 @override
  Widget build(BuildContext context) {
    return BaseView<CRDetailViewModel>(
          onModelReady: (model)=> model.getDefaultData(widget.data),
         builder: (context, model, child) => ScreenTypeLayout(
          mobile: OrientationLayout(
            portrait: (context) => CrDetailViewMobilePortrait(),
            landscape: (context) => CrDetailViewMobileLandscape(),
          ),
          tablet: CrDetailViewMobileLandscape(),
        ),
      
    );
  }
}
