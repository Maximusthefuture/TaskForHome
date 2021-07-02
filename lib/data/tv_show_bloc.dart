import 'package:rxdart/rxdart.dart';
import 'package:tasks_for_home/domain/json_models.dart';

import 'movies_reposilory_impl.dart';

class TVShowBloc {

  final _repository = MoviesRepositoryImpl();
  final _tvShowsFetcher = PublishSubject<List<Results>>();
  Stream<List<Results>> get popularTvShows => _tvShowsFetcher.stream;

  fetchPopularTvShows() async {
  List<Results>? result = await _repository.fetchPopularTvShows();
    _tvShowsFetcher.sink.add(result!);
  }

  dispose() {
    
    _tvShowsFetcher.close();

  }
}


final bloc = TVShowBloc();