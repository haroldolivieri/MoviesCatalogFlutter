import 'genre_response.dart';
import 'movie_response.dart';

class MovieModel{
    final Movie movie;
    final List<Genre> genres;
    
    const MovieModel({this.movie, this.genres});
}