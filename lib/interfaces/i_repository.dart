import 'package:CrResposiveApp/models/es_todo_model.dart';
import 'package:CrResposiveApp/models/result.dart';

abstract class IRepository{

  Future<ResultAndStatus> gettypicodephotosbyIdRepo(int albumId);
}