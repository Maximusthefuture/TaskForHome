import 'package:cloud_firestore/cloud_firestore.dart';

class MovieRecommendation {
  String? name;
  List? recommendationList;
  DocumentReference? reference;

  // MovieRecommendation({required this.name, required this.recommendation, required this.reference})

  MovieRecommendation.fromSnapshot(DocumentSnapshot snapshot) {
    name = snapshot['name'];
    recommendationList = snapshot['recommendation'];
    reference = snapshot.reference;
  }

  List<MovieRecommendation> getMovieFromQuery(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return MovieRecommendation.fromSnapshot(doc);
    }).toList();
  }

  Stream<QuerySnapshot> loadAllRestaurants() {
    return FirebaseFirestore.instance.collection('restaurants').snapshots();
  }
}
