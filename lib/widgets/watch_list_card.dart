import 'package:flutter/material.dart';
import 'package:tasks_for_home/domain/movie_recomednation.dart';

class WatchListCard extends StatelessWidget {
  const WatchListCard({this.recommendation});

  final MovieRecommendation? recommendation;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 250,
        child: Column(
          children: [
            Expanded(child: Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(""),
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
                        "name"
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
