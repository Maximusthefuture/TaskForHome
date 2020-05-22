import 'package:flutter/cupertino.dart';
import 'package:tasks_for_home/data/movies_reposilory_impl.dart';
import 'package:tasks_for_home/domain/json_models.dart';

class MovieDetailsWidget extends StatelessWidget {
  MoviesRepositoryImpl repositoryImpl = MoviesRepositoryImpl();
  List<MovieDetails> list;
  int id = 123123;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('${list[0].overview}'),
    );
  }
}
