import 'package:flutter/material.dart';
import 'package:tasks_for_home/data/buy_todo_list.dart';

class BuyListCell extends StatefulWidget {
  @override
  _BuyListCellState createState() => _BuyListCellState();
}

class _BuyListCellState extends State<BuyListCell> {
  bool? isChecked = false;

  List<BuyList> buyList = [];

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
            Text("Some text"),
            GestureDetector(
              child: Container(
                  height: 50,
                  width: 50,
                  child: Image.network('https://picsum.photos/250?image=9')),
              onTap: () => showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(width: 16)),
                  context: context,
                  builder: (BuildContext context) {
                    return modalBottomShit();
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget modalBottomShit() {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      color: Colors.amber,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
                width: 100,
                height: 100,
                child: Image.network('https://picsum.photos/250?image=9')),
            const Text('Modal BottomSheet'),
            ElevatedButton(
              child: const Text('Close BottomSheet'),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
      ),
    );
  }
}
