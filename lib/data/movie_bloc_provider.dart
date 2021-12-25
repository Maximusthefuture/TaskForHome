import 'package:flutter/material.dart';
import 'package:tasks_for_home/data/movies_bloc.dart';

class MovieBlocProvider extends InheritedWidget {
  final MoviesBloc? bloc;

  MovieBlocProvider({key, child})
  : bloc = MoviesBloc(), super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static MoviesBloc? of(BuildContext context) {
      return (context.dependOnInheritedWidgetOfExactType<MovieBlocProvider>()?.bloc);
      
  }

}