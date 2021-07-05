import 'package:tasks_for_home/data/buy_todo_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasks_for_home/data/todo_list_repository.dart';

class TodoListRepositoryImpl extends TodoListRepository {
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
  List<BuyList> getItemFromQuery(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return BuyList.fromSnapshot(doc);
    }).toList();
  }
}
