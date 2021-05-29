import 'dart:convert';

import 'package:tasks_for_home/domain/json_models.dart';
import 'package:http/http.dart' as http;

class MoviesApiProvider {
  static const String _api_key = '6efc87390c4c8501566dd6c4cd3a09c5';


  List<PopularTvShows> getPopularTvShows(String body)  {
     return PopularTvShows.fromJson(json.decode(body)).results;
  }

  Future<List<Results>> fetchPopular() async {
    final response = await http
        .get(Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=${_api_key}'));
    return getPopularMovies(response.body);
  }

  List<Results> getPopularMovies(String body) {
    return PopularMovies.fromJson(json.decode(body)).results;
  }

  MovieDetails getMovieDetails(String body) {
    // final parsed = json.decode(body);
    return MovieDetails.fromJson(json.decode(body));
  }

  Future<MovieDetails> fetchMovieById(int id) async {
    final response = await http
        .get(Uri.parse('https://api.themoviedb.org/3/movie/$id?api_key=$_api_key'));
    return getMovieDetails(response.body);
  }
}
