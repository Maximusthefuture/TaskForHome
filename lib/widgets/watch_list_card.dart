import 'package:flutter/material.dart';
import 'package:tasks_for_home/domain/movie_recomednation.dart';
import 'package:tasks_for_home/domain/watch_list.dart';

class WatchListCard extends StatelessWidget {
  const WatchListCard({this.recommendation});

  final WatchListModel? recommendation;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 400,
        child: Column(
          children: [
            Expanded(child: Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://image.tmdb.org/t/p/w780${recommendation?.movieIcon}"),
                  fit: BoxFit.cover
                )
              ),
              child: null
            )),
            Padding(padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${recommendation?.name}"
                      ),
                    )
                  ],
                )
              ],
            ),)
          ],
        ),
      ),
    );
  }
}
