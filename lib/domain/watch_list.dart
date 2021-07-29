import 'package:cloud_firestore/cloud_firestore.dart';

class WatchListModel {
  String? name;
  String? id;
  String? movieIcon;
  String? movieName;
  int? movieId;
  // List<String?>? array;
  DocumentReference? reference;

  WatchListModel({this.name, this.movieIcon, this.movieName, this.movieId}) : id = null;

  WatchListModel.fromSnapshot(DocumentSnapshot snapshot)
      : assert(snapshot != null),
        id = snapshot.id,
        name = snapshot['name'],
        // array = snapshot['array'],
        movieIcon = snapshot['posterPath'],
        movieName = snapshot['movieName'],
        movieId = snapshot['movieId'],
        reference = snapshot.reference;
}


 
