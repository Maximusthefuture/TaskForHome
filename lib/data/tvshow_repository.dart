
import 'package:tasks_for_home/domain/json_models.dart';

abstract class TvShowRepository {
  Future<List<PopularTvShows>> fetchPopularTvShows();
}