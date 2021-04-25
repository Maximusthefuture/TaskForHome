import 'package:rxdart/rxdart.dart';
import 'package:tasks_for_home/domain/json_models.dart';

import 'movies_reposilory_impl.dart';

class MoviesBloc {
  final _repository = MoviesRepositoryImpl();
  final _moviesFetcher = PublishSubject<List<Results>>();
 
  Stream<List<Results>> get popularMovies => _moviesFetcher.stream;

  fetchPopularMovies() async {
    List<Results> result = await _repository.fetchPopularMovies();
    _moviesFetcher.sink.add(result);
  }

  dispose() {
    _moviesFetcher.close();

  }
}

final bloc = MoviesBloc();