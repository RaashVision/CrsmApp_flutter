import 'package:ESmile/models/es_todo_model.dart';

abstract class ILocalDatabase{

  Future<int> insertTodo(ESTodoModel esTodoModel);

  Future<int> updateTodo(ESTodoModel esTodoModel);

  Future<List<ESTodoModel>> getAllESTodoList();

  Future<int> deleteTodo(ESTodoModel esTodoModel);

  Future<int> deleteall();

  

  
}