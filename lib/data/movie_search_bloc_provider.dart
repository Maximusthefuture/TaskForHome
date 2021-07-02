import 'package:flutter/material.dart';
import 'package:tasks_for_home/data/movie_search_bloc.dart';

class MovieSearchBlocProvider extends InheritedWidget {
  final MovieSearchBloc? bloc;

  MovieSearchBlocProvider({key, child})
  : bloc = MovieSearchBloc(), super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static MovieSearchBloc? of(BuildContext context) {
      return (context.dependOnInheritedWidgetOfExactType<MovieSearchBlocProvider>()?.bloc);
      
  }

}