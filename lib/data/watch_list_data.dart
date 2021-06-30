

 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasks_for_home/domain/watch_list.dart';

List<WatchListModel> getMovieFromQuery(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return WatchListModel.fromSnapshot(doc);
    }).toList();
  }

  Stream<QuerySnapshot> loadAllRestaurants() {
    return FirebaseFirestore.instance.collection('watch_list').snapshots();
  }