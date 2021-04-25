import 'package:tasks_for_home/domain/json_models.dart';

abstract class MoviesRepository {
  Future<List<Results>> fetchPopularMovies();
  Future<MovieDetails> fetchMovieById(int id);
}
