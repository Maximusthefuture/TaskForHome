

import 'package:flutter/material.dart';
import 'package:tasks_for_home/data/buy_todo_list.dart';
import 'package:tasks_for_home/data/login_state.dart';
import 'package:tasks_for_home/data/todo_list_repository_impl.dart';

class BuyListAddMenuBottomSheet extends StatefulWidget {
  final TextEditingController? myController;
  final LoginState? appState;
  BuyList? buyListModel;
  final TodoListRepositoryImpl? repository;
  BuyListAddMenuBottomSheet({@required this.myController, @required this.appState, Key? key, @required this.buyListModel, @required this.repository }) : super(key: key);

  @override
  _BuyListAddMenuBottomSheetState createState() => _BuyListAddMenuBottomSheetState();
}

class _BuyListAddMenuBottomSheetState extends State<BuyListAddMenuBottomSheet> {
    int? _value = 0;
    bool saveToLocal = true;
    String? category = "";
    bool? local = true;
  List<String> list = <String>["Home", "Study", "Work", "Buy", "Clean"];
  @override
  Widget build(BuildContext context) {
      return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(10.0),
                  topRight: const Radius.circular(10.0))),
          height: MediaQuery.of(context).size.height / 4,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.all(16),
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      autofocus: true,
                      decoration: InputDecoration(
                          hintText: "Fare cose",
                          errorText: "Value can't be empty"),
                      controller: widget.myController,
                    )),
                Row(
                  children: [
                    Container(
                        padding: EdgeInsets.only(left: 16),
                        child:
                            // IconButton(onPressed: null, icon: Icon(Icons.ac_unit)),
                            Wrap(
                          children: List<Widget>.generate(
                            list.length,
                            (int index) {
                              return Container(
                                  padding: EdgeInsets.only(right: 8),
                                  child: ChoiceChip(
                                    selectedColor: Colors.red,
                                    label: Text('${list[index]}'),
                                    selected: _value == index,
                                    onSelected: (bool selected) {
                                      setState(() {
                                        _value = selected ? index : null;
                                        category = list[index];
                                        print("category: ${category}");
                                      });
                                    },
                                  ));
                            },
                          ).toList(),
                        ))
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    IconButton(
                        onPressed: () {
                          // showAlert(list);
                        },
                        icon: Icon(Icons.flag)),
                    IconButton(
                        onPressed: () {
                          local = false;
                        },
                        icon: Icon(Icons.mail)),
                    IconButton(
                        onPressed: () {
                          print("${saveToLocal}");
                          setState(() {
                            saveToLocal = !saveToLocal;
                          });
                        },
                        icon: saveToLocal
                            ? Icon(Icons.person)
                            : Icon(Icons.groups)),
                    Spacer(),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: GestureDetector(
                              child: Icon(Icons.send),
                              onTap: () {
                                widget.buyListModel = BuyList(
                                    category: category,
                                    item: widget.myController?.text,
                                    isChecked: 0);
                                //TODO: SQLITE?

                                // if (showToAll) {
                                //   appState.addTodoList(buyListModel!);
                                // } else {
                                //   // sqlite.addTodoList();
                                // }
                                setState(() {
                                   saveToLocal
                                    ? widget.repository!
                                        .addTodo(widget.buyListModel!, saveToLocal)
                                    : widget.repository!.addTodo(widget.buyListModel!, false);
                                print(saveToLocal);
                                });
                               

                                widget.myController?.clear();
                                final snackBar = SnackBar(
                                    content: saveToLocal
                                        ? Text('Added to db')
                                        : Text("Added to firebase"));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                // Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              onLongPress: () {
                                //TODO ADD TIME PICKER
                                // showDialog(
                                //     context: context,
                                //     builder: (builder) {
                                //       return AlertDialog(
                                //         title: Text("TITLE"),
                                //       );
                                //     });
                                widget.buyListModel = BuyList(
                                    category: category,
                                    item: widget.myController?.text,
                                    isChecked: 0);
                                local = false;

                                print("LONG PRESS");
                                //showSnackBar
                                final snackBar =
                                    SnackBar(content: Text('Added to list'));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                Navigator.pop(context);
                              },
                            ))),
                  ],
                ),
              ],
            ),
          ));
    
  }
}

// Widget modalBottomShit(BuildContext context,
//       TextEditingController myController, LoginState appState) {
    
//     // var dropdownValue = "Дом";
//     return StatefulBuilder(builder: (context, setModalState) {
      
//     });
//   }