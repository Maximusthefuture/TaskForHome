import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks_for_home/presentation/screens/add_edit_todo_screen.dart';
import 'package:tasks_for_home/widgets/buy_list_cell.dart';

class BuyListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buy List"),
        actions: <Widget>[
          IconButton(
            icon: Icon(CupertinoIcons.add),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return AddEditTodoItem();
                }));
            },
          ),
          IconButton(
            icon: Icon(Icons.plus_one_sharp),
            onPressed: () {
              
            },
          ),
        ],
      ),
      body: Container(
        child: ListView.builder(
            itemCount: 20,
            itemBuilder: (BuildContext context, int index) {
              return BuyListCell();
            }),
      ),
    );
  }
}
