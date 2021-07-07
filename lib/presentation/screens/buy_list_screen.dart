import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks_for_home/data/buy_todo_list.dart';
import 'package:tasks_for_home/data/login_state.dart';
import 'package:tasks_for_home/data/todo_list_repository_impl.dart';
import 'package:tasks_for_home/widgets/buy_list_cell.dart';

class BuyListScreen extends StatefulWidget {
  const BuyListScreen({Key? key}) : super(key: key);

  @override
  _BuyListScreenState createState() => _BuyListScreenState();
}

class _BuyListScreenState extends State<BuyListScreen> {
  TodoListRepositoryImpl repository = new TodoListRepositoryImpl();
  //TODO: need personal list?

  List<BuyList> buyList = [];
  StreamSubscription<QuerySnapshot>? _streamSubscription;

  void _updateWatchList(QuerySnapshot snapshot) {
   
      setState(() {
        buyList = repository.getItemFromQuery(snapshot);
      });

  }

  _BuyListScreenState() {
    // if (!showCheckedItems) {
    _streamSubscription = repository.getAllTodoItems().listen(_updateWatchList);
    // } else {
      // _streamSubscription = repository.getDoneItems().listen(_updateWatchList);
    // }
  }

  bool showToAll = true;
  String category = "Home";
  BuyList? buyListModel;
  bool showCheckedItems = false;
  List<String> list = <String>["Home", "Study", "Work", "Buy", "Clean"];
  final myController = TextEditingController();
  FocusNode? focusNode;
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
    var provider = Provider.of<LoginState>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text("Buy List"),
        actions: <Widget>[
          IconButton(
            icon: Icon(CupertinoIcons.add),
            onPressed: () {
              showAddItemMenu(context, myController, provider);
            },
          ),
          IconButton(
            icon: Icon(Icons.plus_one_sharp),
            onPressed: () {
              setState(() {
                showCheckedItems = !showCheckedItems;
                print(showCheckedItems);
              });
            },
          ),
        ],
      ),
      body: Container(
        child: ListView.builder(
            itemCount: buyList.length,
            itemBuilder: (BuildContext context, int index) {
              var item = buyList[index];
              if (!item.isChecked!) {
                return Dismissible(
                    key: Key("f"),
                    onDismissed: (direction) {
                      setState(() {
                        buyList.removeAt(index);
                        // item.isChecked = false;
                        provider.updateTodoData(item.reference!.id, true);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Deleted"),
                      ));
                    },
                    background: Container(color: Colors.red),
                    child: BuyListCell(item));
              } else if (item.isChecked! && showCheckedItems) {
                return BuyListCell(item);
              }
              return Container();
              // return Container();
            }),
      ),
    );
  }

  Widget modalBottomShit(BuildContext context,
      TextEditingController myController, LoginState appState) {
    // var dropdownValue = "Дом";
    return Container(
      height: MediaQuery.of(context).size.height / 6,
      // color: Colors.amber,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "Fare cose"
                    
                  ),
                  controller: myController,
                  
                )),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                IconButton(
                    onPressed: () {
                      showAlert(list);
                    },
                    icon: Icon(Icons.flag)),
                IconButton(onPressed: () {}, icon: Icon(Icons.mail)),
                Spacer(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                     
                      buyListModel = BuyList(
                          category: category,
                          item: myController.text,
                          isChecked: false);
                          //TODO: SQLITE?
                          if (showToAll)  {
                            appState.addTodoList(buyListModel!);
                          } else {
                            // sqlite.addTodoList();
                          }
                     
                      Navigator.pop(context);
                      myController.clear();
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showAlert(List<String> list) {
    showDialog(
        context: context,
        builder: (builder) {
          // String dropdownValue = 'Дом';
          return StatefulBuilder(builder: (context, myState) {
            return AlertDialog(
                content: DropdownButton<String>(
                    value: category,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValue) {
                      myState(() {
                        // dropdownValue = newValue!;
                        category = newValue!;
                        print("Category $category");
                      });
                    },
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList()));
          });
        });
  }

  void showAddItemMenu(BuildContext context, TextEditingController myController,
      LoginState appState) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: modalBottomShit(context, myController, appState),
          );
        });
  }
}
