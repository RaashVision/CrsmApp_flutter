
import 'package:CrResposiveApp/models/result.dart';

abstract class IApi{

  Future<ResultAndStatus> gettypicodephotosbyId(int albumId);


}
