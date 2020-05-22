import 'package:tasks_for_home/domain/json_models.dart';

abstract class MoviesRepository {

  List<Results> getPopularMovies(String body);
  Future<List<Results>> fetchPhotos();
}