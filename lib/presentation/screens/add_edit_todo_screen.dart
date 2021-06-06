import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddEditTodoItem extends StatefulWidget {
  @override
  _AddEditTodoItemState createState() => _AddEditTodoItemState();
}

class _AddEditTodoItemState extends State<AddEditTodoItem> {
  bool isEdit = true;
  String title = "";
  String f() {
    if (isEdit) {
      return "Edit";
    } else {
      return "Add";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(f()),
      ),
      body: Container(child: 
      StreamBuilder(
        builder: (context, snapshot) {
         
          return Text( snapshot.data.toString());
      },)),
    );
  }
}
