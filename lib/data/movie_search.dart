import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks_for_home/data/movie_search_bloc.dart';
import 'package:tasks_for_home/data/movie_search_bloc_provider.dart';
import 'package:tasks_for_home/domain/json_models.dart';
import 'package:tasks_for_home/domain/watch_list.dart';

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
                          return GestureDetector(onTap:() {
                            Navigator.of(context).pushNamed("routeName");
                          },
                          child:MovieSearchResultWidget(
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

void addToWatchList(
    LoginState appState, Results? snapshot, BuildContext context) {
  // appState.addToWatchList([snapshot?.posterPath]);
  final snackBar = SnackBar(
      content: Text(
          "${snapshot?.name ?? snapshot?.originalTitle} added to watch list"));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
  var name = FirebaseAuth.instance.currentUser?.displayName;
  appState.addWatchList(WatchListModel(
      name: name,
      movieIcon: snapshot?.posterPath,
      movieName: snapshot?.originalTitle,
      movieId: snapshot?.id));
}

class MovieSearchResultWidget extends StatelessWidget {
  final Results? snapshot;

  const MovieSearchResultWidget({key, this.snapshot}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LoginState>(context, listen: true);

    //TODO: 1.Some error cuz of gesturedetector
    //TODO: 2. Make grid?
    // return Container(child: GestureDetector(onTap: () {

    //   addToWatchList(provider, snapshot, context);
    // child:

    // return Container(
    //     child: Row(children: [
    return Container(
        height: 100,
        width: 100,
        child: Image.network(
      "https://image.tmdb.org/t/p/w780${snapshot?.posterPath ?? snapshot?.backdropPath}",
      fit: BoxFit.fill,
    ));
    // Text("${snapshot?.title ?? snapshot?.name}"),
  }
}
