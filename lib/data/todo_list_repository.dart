import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasks_for_home/data/buy_todo_list.dart';

abstract class TodoListRepository<T extends QuerySnapshot> {
  List<BuyList> getItemFromQuery(QuerySnapshot snapshot);
  Stream<QuerySnapshot> getAllTodoItems();
  Stream<QuerySnapshot> getDoneItems();
  Future<void> addTodo(BuyList buyList, bool local);
  //TODO: ADD LOCALLY
  // addItemToDB(BuyList buyList);
  //getItemFromDB(BuyList buyList);

}