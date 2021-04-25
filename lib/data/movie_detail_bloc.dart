import 'package:rxdart/rxdart.dart';
import 'package:tasks_for_home/domain/json_models.dart';
import 'movies_reposilory_impl.dart';

class MovieDetailBloc {
  final _repository = MoviesRepositoryImpl();
  final _movieId = PublishSubject<int>();

  final _movieDetails = PublishSubject<Future<MovieDetails>>();

  Function(int) get movieById => _movieId.sink.add;

  Stream<Future<MovieDetails>> get movieDetail => _movieDetails.stream;

  MovieDetailBloc() {
    _movieId.stream.transform(_itemTransformer()).pipe(_movieDetails);
  }

  dispose() async{
    _movieId.close();
    await _movieDetails.drain();
    _movieDetails.close();
  }

  _itemTransformer() {
    return ScanStreamTransformer(
      (Future<MovieDetails> movie, int id, int index) {
        movie = _repository.fetchMovieById(id);
        return movie;
      }
    );
  }
}
