import 'package:CrResposiveApp/views/widgets/cr_typicon_widget.dart';
import 'package:flutter/material.dart';
import 'package:CrResposiveApp/constants/route_paths.dart' as routes;

class CRHomeLoadingShimmer extends StatelessWidget {

  final int numOfColuminGrid;

  CRHomeLoadingShimmer({this.numOfColuminGrid});

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(title: Text(routes.appBarTiitle),centerTitle: true,),
          body: SafeArea(
         child: Padding(
           padding: const EdgeInsets.fromLTRB(20,10,20,0),
           child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        //mainAxisSize: MainAxisSize.max,
        children: <Widget>[
              Center(
                            child: ToggleButtons(
                      children: <Widget>[
                        Text("1"),
                        Text("2")
                     
                      ],
                      isSelected: [false,false],
                      onPressed: (int index) {
                        
                      //  model.updatetoggleBtn(index);
                      },
                    ),
              ),
              SizedBox(),

              Flexible(
                  child:  GridView.count(
                    crossAxisCount: numOfColuminGrid,
                    shrinkWrap: true,
                    //scrollDirection: Axis.horizontal,
                    children: List.generate(50, (index) {
                        return  Container( 
                         // height: 60,
                          child: CRTypiconCardWidget(data: null,isLoading: true,));
                      
                    }
            ),
                ),
                 
              )


        ],
      ),
         ),
          ),
    );
  }
}