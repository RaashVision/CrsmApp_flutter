import 'package:CrResposiveApp/models/es_todo_model.dart';
import 'package:CrResposiveApp/models/typicode_photo.dart';
import 'package:CrResposiveApp/views/pages/cr_detail_view/cr_detail_view.dart';
import 'package:CrResposiveApp/views/pages/cr_home_view/cr_home_view.dart';
import 'package:flutter/material.dart';
import 'package:CrResposiveApp/constants/route_paths.dart' as routes;

//This is namvigation route of the app.
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
  
    case routes.HomeRoute:
      //var userName = settings.arguments as String;
      return MaterialPageRoute(builder: (context) => CrHomeView());

 
     case routes.CRDetailRoute :{
       var data = settings.arguments as TypiCodePhoto;
       return  MaterialPageRoute(  builder: (context) => CrDetailView(data: data,));
    }
    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('No path for ${settings.name}'),
          ),
        ),
      );
  }
}