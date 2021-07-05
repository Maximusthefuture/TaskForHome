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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              value: isChecked,
              onChanged: (value) {
                setState(() {
                  isChecked = value;
                  print("${value.toString()}");
                });
              },
            ),
            Text(buyListModel!.item!),
            GestureDetector(
              child: Container(
                  height: 50,
                  width: 50,
                  child: Image.network('https://picsum.photos/250?image=9')),
              onTap: () {
                //TODO: How to show keyboard?
                focusNode?.requestFocus();
                showModalBottomSheet(
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    context: context,
                    builder: (BuildContext context) {
                      return Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: modalBottomShit(),
                      );
                    });
              },
            ),
          ],
        ),
      ),
    );
  }


  
  Widget modalBottomShit() {
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
                      category = BuyCategory.clean;
                      showDialog(
                          context: context,
                          builder: (builder) {
                            return AlertDialog(
                              content:
                             DropdownButton<String>(
                                value: dropdownValue,
                                icon: const Icon(Icons.arrow_downward),
                                iconSize: 24,
                                elevation: 16,
                                style:
                                    const TextStyle(color: Colors.deepPurple),
                                underline: Container(
                                  height: 2,
                                  color: Colors.deepPurpleAccent,
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValue = newValue!;
                                  });
                                },
                                items: <String>[
                                  'One',
                                  'Two',
                                  'Free',
                                  'Four'
                                ].map<DropdownMenuItem<String>>((String value) {
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
                      buyList.add(buyListModel!);
                      print(myController.text);
                      print(buyList.map((e) => e.category));
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
}
