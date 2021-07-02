import 'package:rxdart/rxdart.dart';
import 'package:tasks_for_home/domain/json_models.dart';

import 'movies_reposilory_impl.dart';

class TvShowDetailBloc {
  final _repository = MoviesRepositoryImpl();
  final _tvShowId = PublishSubject<int>();
  final _movieDetails = PublishSubject<Future<MovieDetails>>();
  Function(int) get movieById => _tvShowId.sink.add;
  Stream<Future<MovieDetails>> get movieDetail => _movieDetails.stream; 

  TvShowDetailBloc() {
    _tvShowId.stream.transform(_itemTransformer()).pipe(_movieDetails);
    
  }

  dispose() async {
    _tvShowId.close();
    await _movieDetails.drain();
    _movieDetails.close();
  }

  _itemTransformer() {
    return ScanStreamTransformer<int, Future<MovieDetails>>(
      (movie, id, index) {
        movie = _repository.fetchTvShowById(id);
        return movie;
      },
      _repository.fetchTvShowById(1)
    );
  }
  
}