import 'dart:convert';

import 'package:tasks_for_home/domain/json_models.dart';
import 'package:http/http.dart' as http;

class MoviesApiProvider {
  static const String _api_key = '6efc87390c4c8501566dd6c4cd3a09c5';

  Future<List<Results>?> fetchTvShows() async {
    final response = await http.get(Uri.parse("https://api.themoviedb.org/3/tv/popular?api_key=${_api_key}&language=en-US&page=1"));
    return getPopularTvShows(response.body);
  }

   Future<List<Results>?> fetchTvShowsWithPage(int page) async {
    final response = await http.get(Uri.parse("https://api.themoviedb.org/3/tv/popular?api_key=${_api_key}&language=en-US&page=${page}"));
    return getPopularTvShows(response.body);
  }

  List<Results>? getPopularTvShows(String body)  {
     return PopularTvShows.fromJson(json.decode(body)).results;
  }

  List<Results>? searchData(String body) {
    return SearchTmbd.fromJson(json.decode(body)).results;
  }

  Future<List<Results>?> getSearchData(String query) async {
    final response = await http.get(Uri.parse("https://api.themoviedb.org/3/search/multi?api_key=${_api_key}&language=en-US&query=${query}&page=1&include_adult=false"));
    return searchData(response.body);
  }

  Future<List<Results>?> fetchPopular() async {
    final response = await http
        .get(Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=${_api_key}&page=1'));
    return getPopularMovies(response.body);
  }


  Future<List<Results>?> fetchPopularWithPage(int page) async {
    final response = await http
        .get(Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=${_api_key}&page=${page}'));
    return getPopularMovies(response.body);
  }

  List<Results>? getPopularMovies(String body) {
    return PopularMovies.fromJson(json.decode(body)).results;
  }

  MovieDetails getMovieDetails(String body) {
    // final parsed = json.decode(body);
    return MovieDetails.fromJson(json.decode(body));
  }

  Future<MovieDetails> fetchTvShowById(int id) async {
    final response = await http.get(Uri.parse('https://api.themoviedb.org/3/tv/$id?api_key=${_api_key}&language=en-US'));
    return getMovieDetails(response.body);
  }

  Future<MovieDetails> fetchMovieById(int id) async {
    final response = await http
        .get(Uri.parse('https://api.themoviedb.org/3/movie/$id?api_key=$_api_key'));
    return getMovieDetails(response.body);
  }
}
