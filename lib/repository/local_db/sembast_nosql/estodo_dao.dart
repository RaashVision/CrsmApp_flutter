import 'package:ESmile/interfaces/i_localdatabase.dart';
import 'package:ESmile/models/es_todo_model.dart';
import 'package:sembast/sembast.dart';

import 'dbcontext.dart';

class SembastTodoDAO implements ILocalDatabase{

  //This store is like table
  static const String ESTODO_STORE_NAME = 'estodo';
  // A Store with int keys and Map<String, dynamic> values.
  // This Store acts like a persistent map, values of which are Fruit objects converted to Map
  final _esTodoStore = intMapStoreFactory.store(ESTODO_STORE_NAME);

  // Private getter to shorten the amount of code needed to get the
  // singleton instance of an opened database.
  Future<Database> get _db async => await AppDatabase.instance.database;

  @override
  Future<int> deleteTodo(ESTodoModel esTodoModel) async {
   
        final finder = Finder(filter: Filter.byKey(esTodoModel.id));
       return await _esTodoStore.delete(
          await _db,
          finder: finder,
        );
  
  }

  @override
  Future<int> deleteall() async{
     
    return await _esTodoStore.delete(await _db);

  }

  @override
  Future<int> insertTodo(ESTodoModel esTodoModel) async {

      return await _esTodoStore.add(await _db, esTodoModel.toMap());

  }

  @override
  Future<int> updateTodo(ESTodoModel esTodoModel) async {
    // For filtering by key (ID), RegEx, greater than, and many other criteria,
    // we use a Finder.
    final finder = Finder(filter: Filter.byKey(esTodoModel.id));
   return await _esTodoStore.update(
      await _db,
      esTodoModel.toMap(),
      finder: finder,
    );
  }


    @override
  Future<List<ESTodoModel>> getAllESTodoList() async{
    
    // Finder object can also sort data.
    final finder = Finder(sortOrders: [
      SortOrder('createdate',false),
    ]);

    final recordSnapshots = await _esTodoStore.find(
      await _db,
      finder: finder,
    );

    return recordSnapshots.map((snapshot) {
      final health = ESTodoModel.fromMap(snapshot.value);
      // An ID is a key of a record from the database.
      health.id = snapshot.key;
      return health;
    }).toList();
  }

  


}