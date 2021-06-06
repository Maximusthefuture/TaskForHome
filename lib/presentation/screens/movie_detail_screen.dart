import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks_for_home/data/movie_detail_bloc.dart';
import 'package:tasks_for_home/data/movie_detail_bloc_provider.dart';
import 'package:tasks_for_home/domain/json_models.dart';
import 'package:tasks_for_home/widgets/movie_details_widget.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int? movieId;

  const MovieDetailsScreen({key, this.movieId}) : super(key: key);
  @override
  MovieDetailsScreenState createState() {
    return MovieDetailsScreenState(movieId ?? 0);
  }
}

class MovieDetailsScreenState extends State<MovieDetailsScreen> {
  final int? movieId;
  MovieDetailBloc? bloc;
  MovieDetails? details = MovieDetails();

   MovieDetailsScreenState(this.movieId);

  @override
  void didChangeDependencies() {
    bloc = MovieDetailBlocProvider.of(context);
    bloc?.movieById(movieId ?? 0);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: StreamBuilder<Future<MovieDetails>?> (
        stream: bloc?.movieDetail,
        builder: (context, snapshot) {
           var data = snapshot as Future<MovieDetails>;
          if (snapshot.hasData) {
            return FutureBuilder<MovieDetails> (
                future: snapshot.data,
                builder: (context, snapshot) {
                  return MovieDetailsWidget(
                    snapshot: snapshot,
                  );
                });
          } else if (snapshot.hasError) {
            print('error :${snapshot.error}');
          }
          return CircularProgressIndicator();
        },
      )),
    );
  }
}
