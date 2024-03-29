import 'package:tasks_for_home/domain/json_models.dart';

abstract class MoviesRepository {
  Future<List<Results>?> fetchPopularMovies();
  Future<MovieDetails> fetchMovieById(int id);
  Future<List<Results>?> fetchPopularTvShows();
  Future<List<Results>?> searchData(String query);
  Future<MovieDetails> fetchTvShowById(int id);
  // Future<TVShowDetails> fetchTvShowById(int id);
}
