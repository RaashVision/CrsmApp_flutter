
import 'package:CrResposiveApp/managers/dialog_manager.dart';
import 'package:flutter/material.dart';
import 'package:CrResposiveApp/managers/lifecycle_manager.dart';
import 'package:CrResposiveApp/views/shared/app_colors.dart';
import 'package:flutter/services.dart';
import 'locator.dart';
import 'services/navigation_service.dart';
import 'package:CrResposiveApp/constants/route_paths.dart' as routes;
import 'package:CrResposiveApp/router.dart' as router;


void main(){

  //WidgetsFlutterBinding.ensureInitialized();

  //Dependecy injectiion
  setupLocator();

     runApp(new MyApp());
}

class MyApp extends StatelessWidget {

  final GlobalKey _key = new GlobalKey();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


   return LifeCycleManager(
      child: MaterialApp(     
        title: 'CrResposiveApp',
        navigatorKey: locator<NavigationService>().navigatorKey,
        onGenerateRoute: router.generateRoute,
        initialRoute: routes.HomeRoute,
         builder: (context, widget) => Navigator(
          onGenerateRoute: (settings) => MaterialPageRoute(
              builder: (context) => DialogManager(
                key: _key,
                child: widget,
              )),
        ),
        theme: ThemeData(
          primaryColor: PrimaryColor,
          floatingActionButtonTheme: FloatingActionButtonThemeData( backgroundColor: FloatingButtonPrimaryColor)
        
      ),
       
         
         
        
      ),
    );

  }
}
