import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks_for_home/data/movie_detail_bloc_provider.dart';
import 'package:tasks_for_home/domain/json_models.dart';
import 'package:tasks_for_home/presentation/screens/movie_detail_screen.dart';

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
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return MovieDetailBlocProvider(
                            child: MovieDetailsScreen(
                            movieId: list![index].id
                          ));
                        }));
                        print("id: ${list![index].id}");
                      },
                      child: Image.network(
                          "https://image.tmdb.org/t/p/w154${list![index].posterPath}"),
                    )));
  }
}
