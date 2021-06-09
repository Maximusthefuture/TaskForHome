import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks_for_home/domain/json_models.dart';

class MovieDetailsWidget extends StatelessWidget {
  final AsyncSnapshot<MovieDetails>? snapshot;

  const MovieDetailsWidget({ key, this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScroller) {
          return <Widget>[
            SliverAppBar(
              pinned: true,
              floating: false,
              expandedHeight: 200,
              actions: <Widget>[
                Icon(Icons.access_alarm),
              ],
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Column(
                  mainAxisSize: MainAxisSize.min,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Flexible(
                      child: Text(
                        "${snapshot?.data?.title}",
                        textDirection: TextDirection.ltr,
                      ),
                    ),
                    Text(
                      '${snapshot?.data?.releaseDate}',
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                ),
                background: Image.network(
                  "https://image.tmdb.org/t/p/w780${snapshot?.data?.backdropPath}",
                  fit: BoxFit.cover,
                ),
              ),
            )
          ];
        },
        body: Padding(
            padding: EdgeInsets.all(1),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                      height: 200,
                      width: 100,
                      child: Image.network(
                          "https://image.tmdb.org/t/p/w780${snapshot?.data?.posterPath}"))),
              Row(
  
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: (Icon(Icons.add)),
                      iconSize: 30,
                      padding: EdgeInsets.all(9),
                      onPressed: () {
                        print("ICONS");
                      },
                    ),
                    Icon(
                      Icons.play_arrow,
                      size: 40,
                    ),
                    Icon(Icons.share),
                  ]),
              Text("${snapshot?.data?.overview}")
            ])));
  }
}
