import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WatchList extends StatefulWidget {
  @override
  _WatchListState createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> {
   List<String> items = ["zopa", "ne zopa", "dada"];

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Watch list"),
          actions: [IconButton(onPressed: () {
              //Modaly search 
          }, icon: Icon(Icons.add))],
        
        ),
        body: Container(
          child:
          ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
              return Container(child: Text('${items[index]}'),);
          
        })));
  }
}
