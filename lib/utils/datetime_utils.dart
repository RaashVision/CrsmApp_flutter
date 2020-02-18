import 'package:ESmile/interfaces/i_datetimeutil.dart';
import 'package:intl/intl.dart';

class DateTimeUtils implements IDateTimeUtils
{

  Future<DateTime> CurrentDatetime() async{

    return DateTime.now();
  }

  @override
  DateTime ConvertStringToDateTime(String date) {
     try {
      var d = new DateFormat('dd-MM-yyyy').parse(date);
      return d;
    } catch (e) {
      return null;
    }
  }



  


}