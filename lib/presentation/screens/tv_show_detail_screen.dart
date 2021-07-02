import 'package:flutter/material.dart';
import 'package:tasks_for_home/data/movie_detail_bloc_provider.dart';
import 'package:tasks_for_home/data/tvshow_detail_bloc.dart';
import 'package:tasks_for_home/data/tvshow_detail_bloc_provider.dart';
import 'package:tasks_for_home/domain/json_models.dart';
import 'package:tasks_for_home/widgets/movie_details_widget.dart';

class TVShowDetailsScreen extends StatefulWidget {
  final int? movieId;

  const TVShowDetailsScreen({key, this.movieId}) : super(key: key);
  @override
  TVShowDetailsScreenState createState() {
    return TVShowDetailsScreenState(movieId ?? 0);
  }
}

class TVShowDetailsScreenState extends State<TVShowDetailsScreen> {
  final int? movieId;
  TvShowDetailBloc? bloc;
  MovieDetails? details = MovieDetails();

   TVShowDetailsScreenState(this.movieId);

  @override
  void didChangeDependencies() {
    bloc = TvShowDetailBlocProvider.of(context);
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
          child: StreamBuilder<Future<MovieDetails>> (
        stream: bloc?.movieDetail,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return FutureBuilder<MovieDetails> (
                future: snapshot.data,
                builder: (context,  AsyncSnapshot<MovieDetails> snapshot) {
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