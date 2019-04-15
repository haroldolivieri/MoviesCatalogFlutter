class Movie {
  int id;
  String title;
  String posterPath;
  String backdropPath;
  double voteAverage;
  double popularity;
  int voteCount;
  List<int> genreIds;
  String overview;
  DateTime releaseDate;
  bool adult;

  Movie(
      {this.id,
      this.title,
      this.posterPath,
      this.backdropPath,
      this.voteAverage,
      this.popularity,
      this.voteCount,
      this.genreIds,
      this.overview,
      this.releaseDate,
      this.adult});

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
      id: json["id"],
      title: json["title"],
      posterPath: json["poster_path"],
      backdropPath: json["backdrop_path"],
      voteAverage: json["vote_average"].toDouble(),
      popularity: json["popularity"].toDouble(),
      voteCount: json["vote_count"],
      genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
      overview: json["overview"],
      releaseDate: DateTime.parse(json["release_date"]),
      adult: json["adult"]);
  
  static List<Movie> fromJsonToList(List<dynamic> json) =>
      List<Movie>.from(json.map((movie) => Movie.fromJson(movie)));
}
