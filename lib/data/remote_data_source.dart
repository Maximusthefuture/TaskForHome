import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:tasks_for_home/data/buy_todo_list.dart';
import 'package:tasks_for_home/data/todo_data_source.dart';

class RemoteDataSouce implements TodoDataSource {
  @override
  Future<void> addTodo(BuyList todoList ) {
     final todo = FirebaseFirestore.instance.collection('todo_list');
    return todo.add({
      'item': todoList.item,
      'category': todoList.category,
      'isDone': todoList.isChecked
    });
  }

  @override
  Future<List<BuyList>> getAllItems() async {
    return [];
  }

}