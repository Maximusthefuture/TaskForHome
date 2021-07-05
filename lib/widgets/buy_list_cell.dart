import 'package:flutter/material.dart';
import 'package:tasks_for_home/data/buy_todo_list.dart';
import 'package:tasks_for_home/data/category.dart';

class BuyListCell extends StatefulWidget {
  BuyList? buyList;
  BuyListCell(this.buyList);
  @override
  _BuyListCellState createState() => _BuyListCellState(buyList);
}

class _BuyListCellState extends State<BuyListCell> {
  bool? isChecked = false;
  BuyCategory? category;
  List<BuyList> buyList = [];
  FocusNode? focusNode;
  BuyList? buyListModel;
  String dropdownValue = 'One';
  final myController = TextEditingController();

  _BuyListCellState(this.buyListModel);
  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
    focusNode?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        child: Card(
          elevation: 5.0,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      buyListModel!.item!,
                      textScaleFactor: 1,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Spacer(),
                Center(child: Text("Home"))
              ],
            ),
          ),
        ));
  }
}
