import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

Stream getDocs() {
  var watchList =
      FirebaseFirestore.instance.collection('watch_list').snapshots();

  // DocumentSnapshot doc = await watchList.get();
  // List list = doc['recommendation'];

  return watchList;
}

class Watch extends StatelessWidget {
  var list = ["ff", "fff", "ffff"];
  var map = {
    "ffff":
        "https://pix10.agoda.net/hotelImages/478594/-1/90da3d13989956f743ce031e01b27369.jpg?s=1024x768",
    "qweqw":
        "https://cdn.vox-cdn.com/thumbor/VYI2U-efVxrd3y6zmiCajyPSTz8=/0x0:3992x2992/1200x800/filters:focal(2483x1821:3121x2459)/cdn.vox-cdn.com/uploads/chorus_image/image/68993490/GettyImages_1032316302.0.jpg",
    "user":
        "https://thebrownidentity.com/wp-content/uploads/2020/07/01-birth-month-If-You-Were-Born-In-Summer-This-Is-What-We-Know-About-You_644740429-icemanphotos.jpg",
    "somoherguys": "https://i.ytimg.com/vi/_K8R7DlYwvw/maxresdefault.jpg"
  };
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LoginState>(context);
    return Container(
        height: 200,
        width: double.infinity,
        child: StreamBuilder(
            stream: getDocs(),
            builder: (context, AsyncSnapshot snapshot) {
              QuerySnapshot snap = snapshot.data;
              List<DocumentSnapshot> document = snap.docs;

              // return ListView.builder(
              //     scrollDirection: Axis.horizontal,
              //     itemCount: document.length,
              //     itemBuilder: (context, index) {
              return createWidget(context, document);
            }));
  }
}

Widget createWidget(BuildContext context, List array) {
  int? index = 0;
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
            index = index;
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
