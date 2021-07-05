import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tasks_for_home/data/buy_todo_list.dart';
import 'package:tasks_for_home/data/category.dart';
import 'package:tasks_for_home/widgets/buy_list_cell.dart';

class BuyListScreen extends StatefulWidget {
  const BuyListScreen({Key? key}) : super(key: key);

  @override
  _BuyListScreenState createState() => _BuyListScreenState();
}

class _BuyListScreenState extends State<BuyListScreen> {
  BuyCategory? category;
  List<BuyList> buyList = [];
  BuyList? buyListModel;
  String dropdownValue = 'One';
  List<String> list = <String>["One", "Two", "Three", "Four"];
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Buy List"),
        actions: <Widget>[
          IconButton(
            icon: Icon(CupertinoIcons.add),
            onPressed: () {
              showAddItemMenu(context, myController);
            },
          ),
          IconButton(
            icon: Icon(Icons.plus_one_sharp),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        child: ListView.builder(
            itemCount: buyList.length,
            itemBuilder: (BuildContext context, int index) {
              var item = buyList[index];
              return Dismissible(
                  key: Key("f"),
                  onDismissed: (direction) {
                    setState(() {
                      buyList.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Deleted"),
                    ));
                  },
                  background: Container(color: Colors.red),
                  child: BuyListCell(item));
            }),
      ),
    );
  }

  Widget modalBottomShit(
      BuildContext context, TextEditingController myController) {
    var dropdownValue = "One";
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
                  controller: myController,
                )),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                IconButton(
                    onPressed: () {
                      // category = BuyCategory.clean;
                      showDialog(
                          context: context,
                          builder: (builder) {
                            return AlertDialog(
                                content: DropdownButton<String>(
                                    value: dropdownValue,
                                    icon: const Icon(Icons.arrow_downward),
                                    iconSize: 24,
                                    elevation: 16,
                                    style: const TextStyle(
                                        color: Colors.deepPurple),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.deepPurpleAccent,
                                    ),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownValue = newValue!;
                                          category = BuyCategory.values[list.indexOf(newValue)];
                                          print("Category $category");
                                      });
                                    },
                                    items: list.map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList()));
                          });
                    },
                    icon: Icon(Icons.flag)),
                IconButton(onPressed: () {}, icon: Icon(Icons.mail)),
                Spacer(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      buyListModel =
                          BuyList(category: category, item: myController.text);
                          print("Category $category");
                      setState(() {
                        buyList.add(buyListModel!);
                      });

                      // print(myController.text);
                      // print(buyList.map((e) => e.category));

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

  void showAddItemMenu(
      BuildContext context, TextEditingController myController) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: modalBottomShit(context, myController),
          );
        });
  }
}
