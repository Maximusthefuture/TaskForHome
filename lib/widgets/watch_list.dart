import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:tasks_for_home/data/login_state.dart';
import 'package:tasks_for_home/data/watch_list_model.dart';
import 'package:tasks_for_home/domain/watch_list.dart';

class WatchListWidget extends StatelessWidget {
  var list = <String>[];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Watch(),
    );
  }
}

Future getSize() async {
  var productCollection = await 
  FirebaseFirestore.instance.collection('products').get();
  
  return productCollection;
}

Stream<QuerySnapshot> getDocs() {
  var watchList =
      FirebaseFirestore.instance.collection('watch_list').snapshots();
      
  return watchList;
}

class Watch extends StatefulWidget {

   Watch({Key? key}) : super(key: key);
  
  @override
  WatchState createState() => WatchState();
}

class WatchState extends State<StatefulWidget> {
  int? size;
  @override
  void initState() {
    // FirebaseFirestore.instance
    //     .collection('watch_list').snapshots().length.toString();
    // //     .listen((event) {
    // //   size = event.docs.length;
    // // });
    // print("SIZE ${size}");
    // size = getSize().toInt();
     super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).padding;
    double newheight = height - padding.top - padding.bottom;
    // var provider = Provider.of<LoginState>(context);
    return Container(
        width: 200,
        height: newheight,
        child:  ListView.builder(
            // scrollDirection: Axis.vertical,
            itemCount: 2,
            itemBuilder: (context, index) {
              return Container(
                  height: 200,
                  width: 200,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: getDocs(),
                      builder: (context, AsyncSnapshot snapshot) {
                        QuerySnapshot snap = snapshot.data;
                        List<DocumentSnapshot> document = snap.docs;
                        return createWidget(context, document, index);
                      }));
            }));
  }
}

Widget createWidget(BuildContext context, List array, int index) {
  // int? index = 1;
  DocumentSnapshot doc = array[index];
  var list = doc['recommendation'];
  var name = doc['name'];
  return Container(
      padding: EdgeInsets.all(8),

      // child: GestureDetector(
      //   onTapUp: (_) {
      //     Navigator.of(context)
      //         .push(MaterialPageRoute(builder: (_) {
      //       return MovieDetailBlocProvider(
      //         child: MovieDetailsScreen(
      //         movieId: list![index].id
      //       ));
      //     }));
      //     print("id: ${list![index].id}");
      //   },
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: list.length,
          itemBuilder: (ctx, index) {
            return Column(children: [
              Container(
                  width: 150,
                  height: 150,
                  child: Image.network(
                    "https://image.tmdb.org/t/p/w780${list[index]}",
                  )),
              Text(name),
            ]);
          }));
}
