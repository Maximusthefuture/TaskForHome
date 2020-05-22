import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:tasks_for_home/data/movies_repository.dart';
import 'package:tasks_for_home/domain/json_models.dart';


class MoviesRepositoryImpl implements MoviesRepository {
   static const String api_key= '6efc87390c4c8501566dd6c4cd3a09c5';

  @override
  Future<List<Results>> fetchPhotos() async {
    final response = await http
        .get('https://api.themoviedb.org/3/movie/popular?api_key=$api_key');
    return getPopularMovies(response.body);
  }

  @override
  List<Results> getPopularMovies(String body) {
    return PopularMovies.fromJson(json.decode(body)).results;
  }

  @override
  List<MovieDetails> getMovieDetails(String body) {
    final parsed = json.decode(body).cast<Map<String,dynamic>>();
    return parsed.map<MovieDetails>((json) => MovieDetails.fromJson(json)).toList();
  }

  @override
  Future<List<MovieDetails>> fetchMovieById(int id) async {
    final response = await http.get('https://api.themoviedb.org/3/movie/$id?api_key=$api_key');
    return getMovieDetails(response.body);
  }
}
