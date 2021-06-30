import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tasks_for_home/data/watch_list_data.dart' as data ;
import 'package:tasks_for_home/data/movie_search.dart';
import 'package:tasks_for_home/domain/watch_list.dart';
import 'package:tasks_for_home/widgets/watch_list.dart';

class WatchList extends StatefulWidget {
  @override
  _WatchListState createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> {
  List<String> items = ["zopa", "ne zopa", "dada"];
  List<WatchListModel> _watchList = [];
  StreamSubscription<QuerySnapshot>? _streamSubscription;
  @override
  void initState() {
    super.initState();
    _streamSubscription = data.loadAllRestaurants().listen(_updateWatchList);
  }

  void _updateWatchList(QuerySnapshot snapshot) {
    setState(() {
    _watchList = data.getMovieFromQuery(snapshot);
      
    });
    
  }

  @override
  Widget build(BuildContext context) {
    var moviewSearch = MovieSearch(array: items);
    return Scaffold(
        appBar: AppBar(
          title: Text("Watch list"),
          actions: [
            IconButton(
                onPressed: () {
                  //  showModalBottomSheet(context: context, builder: (builder) {
                  showSearch(context: context, delegate: moviewSearch);
                  // return Text("ff");
                  //  });
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: Container(
            child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return WatchListWidget();
                })));
  }
}
