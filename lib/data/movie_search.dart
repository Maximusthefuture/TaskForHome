import 'package:flutter/material.dart';
import 'package:tasks_for_home/data/authentication.dart';
import 'package:tasks_for_home/data/movie_search_bloc.dart';
import 'package:tasks_for_home/data/movie_search_bloc_provider.dart';
import 'package:tasks_for_home/data/watch_list_model.dart';
import 'package:tasks_for_home/domain/json_models.dart';

class MovieSearch extends SearchDelegate {
  List? array;
  // AsyncSnapshot<List<Results>?> snapshot;

  MovieSearch({required this.array});

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [Text("ff")];
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
    return MovieSearchBlocProvider(
      child: MovieSearchWidget(
        query: query,
      ),
    );

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
                    return ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          print("SNAPSHOT ${snapshot.data?.length}");
                          return MovieSearchResultWidget(
                              snapshot: snapshot.data?.elementAt(index));
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

class MovieSearchResultWidget extends StatelessWidget {
  final Results? snapshot;

  const MovieSearchResultWidget({key, this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: 
        // Consumer<LoginState>(
        //     builder: (context, appState, _) => Column(children: [
        //       if (appState.loginState == ApplicationLoginState.loggedIn) ... [

              
        //           GestureDetector(onTap: () {
                    
        //             print("TAPPED");
        //           }),

        //           //add to list here!
        //           //сразу добавляем в закладки?
        //       ],
                  Container(
                      child: Row(children: [
                    Container(
                        height: 100,
                        width: 100,
                        child: Image.network(
                          "https://image.tmdb.org/t/p/w780${snapshot?.posterPath ?? snapshot?.backdropPath}",
                          fit: BoxFit.cover,
                        )),
                    Text("${snapshot?.title ?? snapshot?.name}"),
                  ]))
                );
  }
}
