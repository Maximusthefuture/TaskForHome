import 'package:rxdart/rxdart.dart';
import 'package:tasks_for_home/data/movie_search.dart';
import 'package:tasks_for_home/data/movies_reposilory_impl.dart';
import 'package:tasks_for_home/domain/json_models.dart';

class MovieSearchBloc {
  final _repository = MoviesRepositoryImpl();
  final _query = PublishSubject<String>();
  final _movieSearch = PublishSubject<Future<List<Results>?>>();
  Function(String) get query => _query.sink.add;
  Stream<Future<List<Results>?>> get movieSearch => _movieSearch.stream;

  MovieSearchBloc() {
    _query.stream.transform(_itemTransformer()).pipe(_movieSearch);
  }

  dispose() async {
    _query.close();
    await _movieSearch.drain();
    _movieSearch.close();
  }

  _itemTransformer() {
    return ScanStreamTransformer<String, Future<List<Results>?>>(
        (movie, query, index) {
          movie = _repository.searchData(query);
          return movie;
        },
        _repository.searchData("The Flash")
    );
  }


}