import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasks_for_home/data/buy_todo_list.dart';

abstract class TodoListRepository {
  List<BuyList> getItemFromQuery(QuerySnapshot snapshot);
  Stream<QuerySnapshot> getAllTodoItems();
  Stream<QuerySnapshot> getDoneItems();

}