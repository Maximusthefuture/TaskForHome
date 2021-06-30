import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks_for_home/data/login_state.dart';
import 'package:tasks_for_home/data/movie_search.dart';
import 'package:tasks_for_home/data/movies_bloc.dart';
import 'package:tasks_for_home/domain/json_models.dart';
import 'package:tasks_for_home/widgets/popular_tv_show.dart';

import 'package:tasks_for_home/widgets/popular_movies.dart';

import 'watch_list_screen.dart';

class MoviesTvSeries extends StatefulWidget {
  @override
  _MoviesTvSeriesState createState() => _MoviesTvSeriesState();
}

class _MoviesTvSeriesState extends State<MoviesTvSeries> {
  // final MoviesRepositoryImpl repositoryImpl = MoviesRepositoryImpl();
  final MoviesBloc bloc = MoviesBloc();

  @override
  void initState() {
    super.initState();
    bloc.fetchPopularMovies();
    bloc.fetchPopularTvShows();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Развлечения'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: MovieSearch(array:[]));
              },
            ),
            IconButton(
              icon: Icon(Icons.album),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return  WatchList();
                }));
              },
            ),
          ],
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(3),
                child: Text(
                  'Popular movies',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                ),
              ),
              StreamBuilder<List<Results>>(
                stream: bloc.popularMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return PopularMoviesWidget(list: snapshot.data);
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                    return Text("${snapshot.error}");
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    print(snapshot.error);
                  }

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              StreamBuilder<List<Results>>(
                stream: bloc.popularTvShows,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print("title: ${snapshot.data?.first}");
                    return PopularTvShowWidget(list: snapshot.data);
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                    return Text("${snapshot.error}");
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    print(snapshot.error);
                  }

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              Text("Watch list")
            ]));
  }
}
