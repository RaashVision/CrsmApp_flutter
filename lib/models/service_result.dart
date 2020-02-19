import 'package:CrResposiveApp/enums/viewstate.dart';

class ServiceResultAndStatus{

  bool isSuccess;
  String errormessage;
  dynamic resultdata;

  ServiceResultAndStatus(this.isSuccess, this.errormessage, this.resultdata);


  getIsSucess(){
    return isSuccess;
  }
  getErrorMessage(){
    return errormessage;
  }
  getData(){
    return resultdata;
  }


}