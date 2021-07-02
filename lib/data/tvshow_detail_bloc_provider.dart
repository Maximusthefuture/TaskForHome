import 'package:flutter/material.dart';
import 'package:tasks_for_home/data/tvshow_detail_bloc.dart';

class TvShowDetailBlocProvider extends InheritedWidget {
  final TvShowDetailBloc? bloc;

  TvShowDetailBlocProvider({key, child})
  : bloc = TvShowDetailBloc(), super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static TvShowDetailBloc? of(BuildContext context) {
      return (context.dependOnInheritedWidgetOfExactType<TvShowDetailBlocProvider>()?.bloc);
      
  }

}