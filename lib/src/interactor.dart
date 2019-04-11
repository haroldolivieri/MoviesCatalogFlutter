import 'package:meta/meta.dart';
import 'package:movies_list/src/data/service.dart';
import 'package:movies_list/src/model/genre.dart';
import 'package:movies_list/src/model/movie.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

typedef MergeMovieInfo = Tuple2<Movie, List<Genre>> Function(Movie movie, List<Genre> genres);

class MoviesInteractor {
  final Service service;

  const MoviesInteractor({@required this.service});

  Stream<List<Tuple2<Movie, List<Genre>>>> getMovies() {
    final moviesStream = Observable.fromFuture(service.fetchMovies()).flatMap((movies) => Observable.fromIterable(movies));
    final genresStream = Observable.fromFuture(service.fetchGenres());

    return Observable.combineLatest2(moviesStream, genresStream, _getMovieAndSpecificGenres).toList().asStream();
  }

  Tuple2<Movie, List<Genre>> _getMovieAndSpecificGenres(Movie movie, List<Genre> genres) {
    final movieGenres = movie.genreIds.map((id) => genres.firstWhere((genre) => genre.id == id)).toList();
    return Tuple2(movie, movieGenres);
  }
}
