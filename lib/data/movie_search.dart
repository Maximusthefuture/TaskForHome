import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks_for_home/data/movie_search_bloc.dart';
import 'package:tasks_for_home/data/movie_search_bloc_provider.dart';
import 'package:tasks_for_home/db/movies_db.dart';
import 'package:tasks_for_home/domain/json_models.dart';
import 'package:tasks_for_home/domain/watch_list.dart';
import 'package:tasks_for_home/helpers/helpers.dart';

import 'login_state.dart';

class MovieSearch extends SearchDelegate {
  List? array;
  // AsyncSnapshot<List<Results>?> snapshot;

  MovieSearch({required this.array});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, array ?? "null");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ChangeNotifierProvider<LoginState>(
        create: (context) => LoginState(),
        builder: (context, _) => MovieSearchBlocProvider(
              child: MovieSearchWidget(
                query: query,
              ),
            ));

    // return Text("NULL");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions

    // return ListView.builder(
    //   itemCount: 10,
    //   itemBuilder: (context, index) {
    //     return Text(array[index].toString());
    // });
    return Text("NULL");
  }
}

class MovieSearchWidget extends StatefulWidget {
  final String? query;
  const MovieSearchWidget({key, this.query}) : super(key: key);

  @override
  _MovieSearchState createState() => _MovieSearchState(query ?? "NULL");
}

class _MovieSearchState extends State<MovieSearchWidget> {
  final String? query;
  MovieSearchBloc? bloc;

  _MovieSearchState(this.query);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getAllMovies();
  }

  @override
  void didChangeDependencies() {
    bloc = MovieSearchBlocProvider.of(context);
    bloc?.query(query ?? "Some");
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder<Future<List<Results>?>>(
            stream: bloc?.movieSearch,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return FutureBuilder<List<Results>?>(
                  future: snapshot.data,
                  builder: (context, snapshot) {
                    // print("SNAPSHOT DATA${snapshot.data!.originalTitle}");
                    return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                MediaQuery.of(context).orientation ==
                                        Orientation.landscape
                                    ? 3
                                    : 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8),
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          print("SNAPSHOT ${snapshot.data?.length}");
                          return GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed("routeName");
                              },
                              child: MovieSearchResultWidget(
                                  snapshot: snapshot.data?.elementAt(index)));
                        });
                  },
                );
              } else if (snapshot.hasError) {
                print("snapshot error");
              }
              return CircularProgressIndicator();
            }));
  }
}

Future insertNewMovie(Results? snapshot) async {
  await MoviesDatabase.instance.insertMovie(
      WatchListModel(movieName: snapshot?.name, movieId: snapshot?.id));
}

// List<WatchListModel> myList = [];
// Future<List<WatchListModel>> getAllMovies() async {
//   var list = await MoviesDatabase.instance.getAllMovies();
//   myList = list;
//   return list;
// }

// Future<bool> isMovieorShowInList(int? id) async {
//   bool? isHave;
//   var list = getAllMovies();
//   myList.forEach((element) {
//     if (element.movieId == id) {
//       isHave = true;
//     }
//   });
//   return isHave ?? false;
// }

class MovieSearchResultWidget extends StatelessWidget {
  final Results? snapshot;

  const MovieSearchResultWidget({key, this.snapshot}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LoginState>(context, listen: true);

    //TODO: 1.Some error cuz of gesturedetector
    //TODO: 2. Make grid?
    // return Container(child: GestureDetector(onTap: () {

    // child:

    // return Container(
    //     child: Row(children: [
    return Container(
        height: 100,
        width: 100,
        child: GestureDetector(

            //Check if this id in db? or check is it in firebase?
            //add in db and in firebase?
            onTap: () async {
              // getAllMovies();
              // if (await isMovieorShowInList(snapshot?.id)) {
              //   final snackBar = SnackBar(content: Text("Already in list"));
              //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
              // } else {
              //   addToWatchList(provider, snapshot, context);
              //   insertNewMovie(snapshot);
              // }
              Helpers.addToWatchListInSearch(provider, snapshot, context);
            },
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  "https://image.tmdb.org/t/p/w780${snapshot?.posterPath ?? snapshot?.backdropPath}",
                  fit: BoxFit.cover,
                ))));
    // Text("${snapshot?.title ?? snapshot?.name}"),
  }
}
