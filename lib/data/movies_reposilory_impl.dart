import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:tasks_for_home/data/movie_api_provider.dart';
import 'package:tasks_for_home/data/movies_repository.dart';
import 'package:tasks_for_home/domain/json_models.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  MoviesApiProvider moviesApiProvider = MoviesApiProvider();

  @override
  Future<List<Results>> fetchPopularMovies() async {
    return moviesApiProvider.fetchPopular();
  }

  @override
  Future<MovieDetails> fetchMovieById(int id) async {
    return moviesApiProvider.fetchMovieById(id);
  }
}
