import 'package:flutter/material.dart';
import 'package:movies_list/src/model/genre.dart';
import 'package:movies_list/src/model/movie.dart';
import 'package:movies_list/src/view_utils.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final List<Genre> genres;

  const MovieCard({Key key, this.movie, this.genres}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return addSymetricMargin(
        horizontal: 5,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black, blurRadius: 6, spreadRadius: 1)],
            borderRadius: new BorderRadius.circular(20),
            image: DecorationImage(
              image: NetworkImage("https://image.tmdb.org/t/p/w500${movie.posterPath}"),
              fit: BoxFit.cover,
            ),
          ),
        ));
  }
}
