import 'package:flutter/material.dart';
import 'package:tasks_for_home/data/movie_search_bloc.dart';
import 'package:tasks_for_home/data/movie_search_bloc_provider.dart';
import 'package:tasks_for_home/domain/json_models.dart';

class MovieSearch extends SearchDelegate {
  List? array;

  MovieSearch({required this.array});

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [Text("ff")];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading

    return Text("");
  }

  @override
  Widget buildResults(BuildContext context) {
    // var result = array?.where((element) {
    //   return element.toLowerCase().contains(query.toLowerCase());
    // });
    // TODO: implement buildResults

    return MovieSearchWidget(query: query);

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
        child: StreamBuilder<Future<Results>?>(
                stream: bloc?.movieSearch,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return FutureBuilder<Results>(
                      future: snapshot.data,
                      builder: (context, snapshot) {
                        print("SNAPSHOT DATA${snapshot.data!.originalTitle}");
                        return Text(snapshot.data.toString());
                      },
                    );
                  } else if(snapshot.hasData) {
                    print("snapshot error");
                  }
                  return CircularProgressIndicator();
                }));
  }
}
