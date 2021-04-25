import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WatchList extends StatefulWidget {
  @override
  _WatchListState createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> {
   List<String> items;

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Watch list"),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
          
          
        }));
  }
}
