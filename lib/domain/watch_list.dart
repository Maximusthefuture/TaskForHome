import 'package:cloud_firestore/cloud_firestore.dart';

class WatchListModel {
  String? name;
  String? id;
  String? movieIcon;
  String? movieName;
  int? movieId;
  // List<String?>? array;
  DocumentReference? reference;
  //TODO !!!
  // bool? isMovie;

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

  
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      'name': name,
      'movieIcon': movieIcon,
      'movieName': movieName,
      'movieId': movieId
    };
  }

  factory WatchListModel.fromMap(Map<String, dynamic> data) {
    return WatchListModel(
      // data['id'],
      name: data['name'],
      movieId: data['movieId'],
      movieName: data['movieName'],
      movieIcon: data['movieIcon'],
    );
  }
}


 
