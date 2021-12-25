import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks_for_home/data/login_state.dart';
import 'package:tasks_for_home/data/movie_bloc_provider.dart';
import 'package:tasks_for_home/data/movie_search.dart';
import 'package:tasks_for_home/data/movies_bloc.dart';
import 'package:tasks_for_home/data/tv_show_bloc.dart';
import 'package:tasks_for_home/domain/json_models.dart';
import 'package:tasks_for_home/widgets/popular_tv_show.dart';

import 'package:tasks_for_home/widgets/popular_movies.dart';

import 'watch_list_screen.dart';

class MoviesTvSeries extends StatefulWidget {
  final int? page;
  const MoviesTvSeries({Key? key, @required this.page}) : super(key: key);

  @override
  _MoviesTvSeriesState createState() => _MoviesTvSeriesState();
}

class _MoviesTvSeriesState extends State<MoviesTvSeries> {
  // final MoviesRepositoryImpl repositoryImpl = MoviesRepositoryImpl();
  MoviesBloc? bloc = MoviesBloc();
  final TVShowBloc tvShowBloc = TVShowBloc();
  int pageNumber = 1;
  ScrollController? scrollController;

  @override
  void initState() {
    super.initState();
    // bloc = MoviesBloc();
    // bloc?.fetchPopularMovies();
    scrollController = ScrollController()..addListener(scrollListener);
    bloc?.fetchPopularMovies(pageNumber);
    tvShowBloc.fetchPopularTvShows();
  }

  void scrollListener() {
    //TODO add some var isLoading?
    if (scrollController?.position.pixels ==
        scrollController?.position.maxScrollExtent) {
      bloc?.fetchPopularMovies(pageNumber++);
    }
  }

  @override
  void didChangeDependencies() {
    // bloc = MovieBlocProvider.of(context);
    // bloc?.pageNumber(widget.page ?? 2);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc?.dispose();
    tvShowBloc.dispose();
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
                showSearch(context: context, delegate: MovieSearch(array: []));
              },
            ),
            IconButton(
              icon: Icon(Icons.album),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return WatchList();
                }));
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
              Padding(
                padding: EdgeInsets.all(3),
                child: Text(
                  'Popular movies',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
              StreamBuilder<List<Results>?>(
                stream: bloc?.popularMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return PopularMoviesWidget(
                        list: snapshot.data,
                        scrollViewController: scrollController);
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
                stream: tvShowBloc.popularTvShows,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print("ITS OKEY SHOW");
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
              Text(
                "Latest movies",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Container(
                    color: Colors.red,
                    height: 100,
                    width: 100,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    color: Colors.red,
                    height: 100,
                    width: 100,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    color: Colors.red,
                    height: 100,
                    width: 100,
                  ),
                ],
              ),
              Text("Watch list"),
              Container(
                child: GestureDetector(
                  onTap: () {
                    //  widget.page++;
                    pageNumber++;
                    // print(pageNumber);
                    // bloc?.fetchPopularMovies();
                    // bloc?.pageNumber(pageNumber);
                    bloc?.fetchPopularMovies(pageNumber);
                  },
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Container(
                      child: Text("TEXT"),
                      color: Colors.red,
                    ),
                  ),
                ),
              )
            ])));
  }
}
