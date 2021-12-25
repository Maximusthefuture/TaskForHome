import 'package:rxdart/rxdart.dart';
import 'package:tasks_for_home/domain/json_models.dart';

import 'movies_reposilory_impl.dart';

class MoviesBloc {
  final _listOfResults = <Results>[];
  final _repository = MoviesRepositoryImpl();
  final _moviesFetcher = PublishSubject<List<Results>?>();
  final _tvShowsFetcher = PublishSubject<List<Results>>();
  final _pageNumber = PublishSubject<int>();
 
  Function(int) get pageNumber => _pageNumber.sink.add;
  Stream<List<Results>?> get popularMovies => _moviesFetcher.stream;
  Stream<List<Results>> get popularTvShows => _tvShowsFetcher.stream;

  fetchPopularMovies(int page) async {
    
    List<Results>? result = await _repository.fetchMoviesByPage(page);
    _listOfResults.addAll(result!);
    _moviesFetcher.sink.add(_listOfResults);
  }

  fetchPopularTvShows() async {
  List<Results>? result = await _repository.fetchPopularTvShows();
    _tvShowsFetcher.sink.add(result!);
    
  }

  // MoviesBloc() {
  //   _pageNumber.stream.transform(_itemTransformer()).pipe(_moviesFetcher);
  // }

  dispose() async {
    _moviesFetcher.close();
    await _moviesFetcher.drain();
    _tvShowsFetcher.close();
    _pageNumber.close();

  }

  _itemTransformer() {
    return ScanStreamTransformer<int, Future<List<Results>?>>(
        (movies, page, index) {
            movies =  _repository.fetchMoviesByPage(page);
            return movies;
        },
        _repository.fetchMoviesByPage(1)
    );
  }

  
}

final bloc = MoviesBloc();