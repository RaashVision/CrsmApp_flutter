import 'package:ESmile/viewmodels/cr_home_viewmodel.dart';
import 'package:ESmile/views/core/base_view.dart';
import 'package:ESmile/views/pages/cr_home_view/cr_home_mobile_portrait.dart';
import 'package:ESmile/views/responsive/orientation_layout.dart';
import 'package:ESmile/views/responsive/screen_type_layout.dart';
import 'package:flutter/material.dart';

import 'cr_home_mobile_landscape.dart';


class CrHomeView extends StatefulWidget {
  @override
  _CrHomeViewState createState() => _CrHomeViewState();
}

class _CrHomeViewState extends State<CrHomeView> {
 @override
  Widget build(BuildContext context) {
    return BaseView<CRHomeViewModel>(
        onModelReady: (model)=> model.getDefaultData(),
         builder: (context, model, child) => ScreenTypeLayout(
          mobile: OrientationLayout(
            portrait: (context) => CrHomeViewMobilePortrait(),
            landscape: (context) => CrHomeViewMobileLandscape(),
          ),
          tablet: CrHomeViewMobileLandscape(),
        ),
      
    );
  }
}


