import 'package:cloud_firestore/cloud_firestore.dart';

class WatchListModel {
  String? name;
  String? id;
  String? movieIcon;
  List<String?>? array;
  DocumentReference? reference;

  WatchListModel({this.name, this.movieIcon, this.array}) : id = null;

  WatchListModel.fromSnapshot(DocumentSnapshot snapshot)
      : assert(snapshot != null),
        id = snapshot.id,
        name = snapshot['name'],
        array = snapshot['array'],
        movieIcon = snapshot['posterPath'],
        reference = snapshot.reference;
}


 
