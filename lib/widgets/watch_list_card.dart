import 'package:flutter/material.dart';
import 'package:tasks_for_home/data/movie_detail_bloc_provider.dart';
import 'package:tasks_for_home/domain/movie_recomednation.dart';
import 'package:tasks_for_home/domain/watch_list.dart';
import 'package:tasks_for_home/presentation/screens/movie_detail_screen.dart';

class WatchListCard extends StatelessWidget {
  WatchListCard({this.recommendation});
  bool isMovie = false;
  final WatchListModel? recommendation;
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          height: 400,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: GestureDetector(
                //Need to recognise what is it, movie or tv series
                onTapUp: (_) {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    if (isMovie) {
/*
MovieDetailBlocProvider(
                          // child: MovieDetailsScreen(
                        child: MovieDetailsScreen(movieId: list![index].id),
*/

                      return MovieDetailBlocProvider(
                          child: MovieDetailsScreen(
                              movieId: recommendation?.movieId));
                    } else {
                      return MovieDetailBlocProvider(
                          child: MovieDetailsScreen(
                              movieId: recommendation?.movieId));
                    }
                    // return MovieDetailBlocProvider(
                    //     child:
                    //         MovieDetailsScreen(movieId: recommendation?.movieId));
                  }));
                },
                child: Column(
                  children: [
                    Expanded(
                        child: Container(
                      height: 100,
                      width: 150,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            "https://image.tmdb.org/t/p/w780${recommendation?.movieIcon}",
                            fit: BoxFit.cover,
                          )),

                      // alignment: Alignment.centerLeft,
                      // decoration: BoxDecoration(
                      //     image: DecorationImage(
                      //         image: NetworkImage(
                      //             "https://image.tmdb.org/t/p/w780${recommendation?.movieIcon}"),
                      //         fit: BoxFit.cover)),
                      // child: null)
                    )),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(children: [
                                  // Text("${recommendation?.name}"),
                                  Text("${recommendation?.movieName ?? ""}",style: TextStyle(fontWeight: FontWeight.bold),)
                                ]),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                )),
          ),
        ));
  }
}
