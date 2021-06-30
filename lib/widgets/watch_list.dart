import 'package:flutter/material.dart';
import 'package:tasks_for_home/domain/watch_list.dart';

class WatchListWidget extends StatelessWidget {
  final List<WatchListModel>? list;
  WatchListWidget({this.list});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: WatchStateless(list: list),
    );
  }
}

class WatchStateless extends StatelessWidget {
  final List<WatchListModel>? list;
  WatchStateless({this.list});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).padding;
    double newheight = height - padding.top - padding.bottom;
    // var provider = Provider.of<LoginState>(context);
    return gridView(context, list);
  }
}

Widget gridView(
  BuildContext context,
  List<WatchListModel>? array,
) {
  return GridView.builder(
    itemCount: array?.length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount:
          MediaQuery.of(context).orientation == Orientation.landscape ? 3 : 2,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      childAspectRatio: (2 / 1),
    ),
    itemBuilder: (context, index) {
      print(array?[index]);
      return Container(
          height: 200,
          width: 200,
          child: Column(
            children: [
              Image.network(
                "https://image.tmdb.org/t/p/w780${array?[index].movieIcon}",
              ),
              Text("${array?[index].name}")
            ],
          ));
    },
  );
}

Widget createWidget(BuildContext context, List<WatchListModel>? array) {
  // int? index = 1;
  // DocumentSnapshot doc = array[index];
  // var list = doc['recommendation'];
  // var name = doc['name'];

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
          itemCount: array?.length,
          itemBuilder: (ctx, index) {
            return Column(children: [
              Container(
                width: 150,
                height: 150,
                // child: Image.network(
                //   "https://image.tmdb.org/t/p/w780${list[index]}",
                // )),
                child: Text(array![index].name!),

                // reducedList,
              )
            ]);
          }));
}
