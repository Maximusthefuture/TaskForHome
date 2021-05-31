import 'package:flutter/cupertino.dart';
import 'package:tasks_for_home/data/movie_detail_bloc.dart';

class MovieDetailBlocProvider extends InheritedWidget{
  final MovieDetailBloc? bloc;

  MovieDetailBlocProvider({key, child})
  : bloc = MovieDetailBloc(), super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static MovieDetailBloc? of(BuildContext context) {
      return (context.dependOnInheritedWidgetOfExactType<MovieDetailBlocProvider>()?.bloc);
      
  }

}