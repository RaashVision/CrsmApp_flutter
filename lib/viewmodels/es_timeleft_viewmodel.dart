import 'dart:async';

import 'package:ESmile/enums/viewstate.dart';
import 'package:ESmile/models/es_todo_model.dart';
import 'package:ESmile/viewmodels/core/base_viewmodel.dart';
import 'package:intl/intl.dart';

class ESTimeLeftViewModel extends BaseViewModel{

//Default value shown in UI
  String timeleft = "Calculating";
   @override
  void dispose() {
    super.dispose();
  }

/*This function contain logic for timeleft

Logic explanation

if currect datetime is in between startdate and enddate
  calculate the time left between currentdate and end date and display to ui

else if currect datetime before startdate
    display "Not yet start"

else if currect datetime is after startdate and enddate
    basically expired, disable the UI, Display Expired
else
  display 00hrs 00min


*/
   String timeleftLogic(ESTodoModel esTodoModel){


      DateTime currectdatetime = DateTime.now();
     Duration remaining;
     String twoDigitMinutes;
     String twoDigitSeconds;
     DateFormat format = DateFormat("mm ss");
     int now = currectdatetime.millisecondsSinceEpoch;

      //IF current date in after the start date
      if(currectdatetime.isAfter(esTodoModel.startdate) && currectdatetime.isBefore(esTodoModel.enddate) ){

         remaining = Duration(milliseconds: esTodoModel.enddate.millisecondsSinceEpoch - now);

          // If not expired
         if(!remaining.isNegative){
              twoDigitMinutes = twoDigits(remaining.inMinutes.remainder(60));
              twoDigitSeconds = twoDigits(remaining.inSeconds.remainder(60));
              timeleft ="${twoDigits(remaining.inHours)} hrs $twoDigitMinutes min";
              }
          else{
             timeleft = "Expired";
          }
          }
      //If todo list is in future date
      else if(currectdatetime.isBefore(esTodoModel.startdate)){

         remaining = Duration(milliseconds: esTodoModel.enddate.millisecondsSinceEpoch - esTodoModel.startdate.millisecondsSinceEpoch);

         timeleft = "Not yet started";
      }
      //If expired
      else if(currectdatetime.isAfter(esTodoModel.startdate) && currectdatetime.isAfter(esTodoModel.enddate)){

           timeleft = "Expired";

      }
      //TODO unhandle error if both in same date
      else{
        remaining = Duration(milliseconds: now - esTodoModel.enddate.millisecondsSinceEpoch);

         if(!remaining.isNegative){
              twoDigitMinutes = twoDigits(remaining.inMinutes.remainder(60));
              twoDigitSeconds = twoDigits(remaining.inSeconds.remainder(60));
              timeleft ="${twoDigits(remaining.inHours)} hrs $twoDigitMinutes min";
              }
          else{
             timeleft = "Expired";
          }

      }

      return timeleft;

   }
// just simple function to extract the numebr
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
     }

}