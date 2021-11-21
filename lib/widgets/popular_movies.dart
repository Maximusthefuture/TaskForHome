import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tasks_for_home/data/movie_detail_bloc_provider.dart';
import 'package:tasks_for_home/domain/json_models.dart';
import 'package:tasks_for_home/presentation/screens/movie_detail_screen.dart';
import 'package:tasks_for_home/widgets/custompageroute.dart';

import 'movie_details_widget.dart';

class PopularMoviesWidget extends StatelessWidget {
  final List<Results>? list;

  const PopularMoviesWidget({key, this.list}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    
    return Container(
      height: 200,
      width: double.infinity,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: list?.length,
          itemBuilder: (context, index) {
            return createWidget(context, list, index);
          }),
    );
    
  }

  Widget createWidget(BuildContext context, List? list, int index) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 2),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: GestureDetector(
                onTapUp: (_) {
                  Navigator.push(
                      context,
                      CustomPageRoute(MovieDetailBlocProvider(
                          // child: MovieDetailsScreen(
                        child: MovieDetailsScreen(movieId: list![index].id),
                      )));
                  
                  // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  //   return MovieDetailBlocProvider(
                  //       child: MovieDetailsScreen(movieId: list![index].id));
                  // }));
                  print("id: ${list[index].id}");
                },
                child: Hero(
                  tag: "Movies${list?[index].id}",
                  child: Image.network(
                      "https://image.tmdb.org/t/p/w154${list?[index].posterPath}"),
                  // placeholderBuilder: (context, _, widget) {
                  //   return Opacity(opacity: 0.2, child: widget);
                  // },
                
                  flightShuttleBuilder:
                      (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) {
                        // final Hero toHero = toHeroContext.widget;
                    return FadeTransition(
                        opacity: animation.drive(
                            Tween<double>(begin: 0.0, end: 1.0).chain(
                                CurveTween(
                                    curve: Interval(0.0, 1.0,
                                        curve: ValleyQuadraticCurve())))),
                                        child: toHeroContext.widget);
                                        
                  },
                ))));
  }
}

