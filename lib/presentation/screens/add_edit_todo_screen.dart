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
    return Container(
      // showModalBottomSheet(
      //               isScrollControlled: true,
      //               shape: RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.circular(16),
      //               ),
      //               context: context,
      //               builder: (BuildContext context) {
      //                 return Padding(
      //                   padding: MediaQuery.of(context).viewInsets,
      //                   child: modalBottomShit(context, myController),
      //                 );
      //               });
    );
  }
}




