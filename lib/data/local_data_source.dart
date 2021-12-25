import 'package:tasks_for_home/data/buy_todo_list.dart';
import 'package:tasks_for_home/data/todo_data_source.dart';
import 'package:tasks_for_home/db/buy_list_dao.dart';

class LocalDataSource implements TodoDataSource {
  @override
  Future<void> addTodo(BuyList todoList) {
      return TodoListDB.db.addTodo(todoList);
  }

  @override
  Future<List<BuyList>> getAllItems() {
    return TodoListDB.db.getAllTodo();
  }

}