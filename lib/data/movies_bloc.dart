import 'package:rxdart/rxdart.dart';
import 'package:tasks_for_home/domain/json_models.dart';

import 'movies_reposilory_impl.dart';

class MoviesBloc {
  final _repository = MoviesRepositoryImpl();
  final _moviesFetcher = PublishSubject<List<Results>>();
  final _tvShowsFetcher = PublishSubject<List<Results>>();
  Stream<List<Results>> get popularMovies => _moviesFetcher.stream;
  Stream<List<Results>> get popularTvShows => _tvShowsFetcher.stream;

  fetchPopularMovies() async {
    List<Results>? result = await _repository.fetchPopularMovies();
    _moviesFetcher.sink.add(result!);
  }

  fetchPopularTvShows() async {
  List<Results>? result = await _repository.fetchPopularTvShows();
    _tvShowsFetcher.sink.add(result!);
  }

  dispose() {
    _moviesFetcher.close();
    _tvShowsFetcher.close();

  }
}

final bloc = MoviesBloc();