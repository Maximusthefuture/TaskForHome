import 'buy_todo_list.dart';

abstract class TodoDataSource {
 Future<void> addTodo(BuyList todoList);
 Future<List<BuyList>> getAllItems();
}