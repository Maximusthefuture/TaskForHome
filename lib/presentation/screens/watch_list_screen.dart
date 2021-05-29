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
        ),
        body: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
              return Container(child: Text('${items[index]}'),);
          
        }));
  }
}
