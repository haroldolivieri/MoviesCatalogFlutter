import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:movies_list/src/model/genre.dart';
import 'package:movies_list/src/model/movie.dart';

import 'api_key.dart';

mixin Service {
  Future<List<Movie>> fetchMovies();

  Future<List<Genre>> fetchGenres();
}

class RemoteService implements Service {
  String _baseUrl = "api.themoviedb.org";
  var _queryParameters = {'api_key': API_KEY};

  @override
  Future<List<Movie>> fetchMovies() async {
    var movies = [];
    try {
      final response = await _httpGet("/3/movie/popular", _queryParameters);
      movies = json.decode(response.body)["results"];
    } catch (e) {
      print(e);
    }

    return Movie.fromJsonToList(movies);
  }

  @override
  Future<List<Genre>> fetchGenres() async {
    final response = await _httpGet("/3/genre/movie/list", _queryParameters);
    final genres = json.decode(response.body)["genres"];

    return Genre.fromJsonToList(genres);
  }

  _httpGet(String path, Map<String, String> queryParams) async =>
      await http.get(Uri.https(_baseUrl, path, queryParams));
}

class MockService implements Service {
  @override
  Future<List<Movie>> fetchMovies() async {
    final jsonStr = await rootBundle.loadString('assets/mock_movies.json');
    final movies = json.decode(jsonStr)["results"];

    return Movie.fromJsonToList(movies);
  }

  @override
  Future<List<Genre>> fetchGenres() async {
    final jsonStr = await rootBundle.loadString('assets/mock_genres.json');
    final genres = json.decode(jsonStr)["genres"];

    return Genre.fromJsonToList(genres);
  }
}
