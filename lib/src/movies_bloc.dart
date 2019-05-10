import 'package:movies_list/src/data/service.dart';
import 'package:movies_list/src/model/genre_response.dart';
import 'package:movies_list/src/model/movie_response.dart';
import 'package:rxdart/rxdart.dart';

import 'model/movie.dart';

class MoviesBloc {
  final Service _service = MockService();

  Observable<List<MovieModel>> get allMovies => getMovies();

  Stream<List<MovieModel>> getMovies() {
    final moviesStream = Observable.fromFuture(_service.fetchMovies()).flatMap(
      (movies) => Observable.fromIterable(movies),
    );

    final genresStream = Observable.fromFuture(_service.fetchGenres());

    return Observable.combineLatest2(
      moviesStream,
      genresStream,
      _getMovieAndSpecificGenres,
    ).toList().asStream();
  }

  MovieModel _getMovieAndSpecificGenres(Movie movie, List<Genre> genres) {
    final movieGenres = movie.genreIds.map((id) => genres.firstWhere((genre) => genre.id == id)).toList();
    return MovieModel(movie: movie, genres: movieGenres);
  }
}
