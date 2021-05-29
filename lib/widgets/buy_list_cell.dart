import 'package:flutter/material.dart';
import 'package:tasks_for_home/data/buy_todo_list.dart';


class BuyListCell extends StatelessWidget {
  bool isChecked = false;
  List<BuyList> buyList = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Checkbox(value: isChecked, onChanged: (bool value) {
              isChecked = !value;
           },),
           Text("Some text"),
           GestureDetector(
             child: Icon(Icons.ac_unit, ),
             onTap: () => print("Some tap"),
           ),
           
          ],
        ),
      ),
    );
  }
}