import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks_for_home/data/movie_search.dart';
import 'package:tasks_for_home/widgets/watch_list.dart';

class WatchList extends StatefulWidget {
  @override
  _WatchListState createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> {
   List<String> items = ["zopa", "ne zopa", "dada"];

 
  @override
  Widget build(BuildContext context) {
    var moviewSearch = MovieSearch(array: items);
    return Scaffold(
        appBar: AppBar(
          title: Text("Watch list"),
          actions: [IconButton(onPressed: () {
            //  showModalBottomSheet(context: context, builder: (builder) {
                showSearch(context: context, delegate: moviewSearch);
                // return Text("ff");
            //  });
              
          }, icon: Icon(Icons.add))],
        
        ),

        
        body: Container(
          child:
          ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
           
              return WatchListWidget();
          
        })));
  }
}
