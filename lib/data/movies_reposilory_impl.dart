import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:tasks_for_home/data/movies_repository.dart';
import 'package:tasks_for_home/domain/json_models.dart';


class MoviesRepositoryImpl implements MoviesRepository {
   String _API_KEY = 'YOUR KEY';

  @override
  Future<List<Results>> fetchPhotos() async {
    final response = await http
        .get('https://api.themoviedb.org/3/movie/popular?api_key=$_API_KEY');
    return getPopularMovies(response.body);
  }

  @override
  List<Results> getPopularMovies(String body) {
    return PopularMovies.fromJson(json.decode(body)).results;
  }

  @override
  List<MovieDetails> getMovieDetails(String body) {
    return null;
  }

  @override
  Future<List<MovieDetails>> fetchMovieById(int id) async {
    final response = await http.get('https://api.themoviedb.org/3/movie/$id?api_key=$_API_KEY');
    return getMovieDetails(response.body);
  }
}
