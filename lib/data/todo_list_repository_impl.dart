import 'package:tasks_for_home/data/buy_todo_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasks_for_home/data/local_data_source.dart';
import 'package:tasks_for_home/data/remote_data_source.dart';
import 'package:tasks_for_home/data/todo_data_source.dart';
import 'package:tasks_for_home/data/todo_list_repository.dart';

class TodoListRepositoryImpl<T extends QuerySnapshot>
    implements TodoListRepository {
  TodoDataSource remoteDataSource;
  TodoDataSource localDataSource;

  TodoListRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});

  //TODO Local data and remote data
  @override
  Stream<QuerySnapshot> getAllTodoItems() {
    return FirebaseFirestore.instance.collection('todo_list').snapshots();
  }

  @override
  Stream<QuerySnapshot> getDoneItems() {
    var collection = FirebaseFirestore.instance
        .collection('todo_list')
        .where('isDone', isEqualTo: true);
    return collection.snapshots();
  }

  @override
  List<BuyList> getItemFromQuery(QuerySnapshot snapshot,
      {bool isLocal = false})  {
    // if (isLocal) {
    //   return localDataSource.getAllItems().then((value) => );
    // } else {
      return snapshot.docs.map((doc) {
        return BuyList.fromSnapshot(doc);
      }).toList();
    // }
  }

  @override
  Future<void> addTodo(BuyList buyList, bool local) {
    if (local) {
      return localDataSource.addTodo(buyList);
    } else {
      return remoteDataSource.addTodo(buyList);
    }
  }
}
