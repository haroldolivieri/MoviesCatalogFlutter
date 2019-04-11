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
                  image: DecorationImage(image: AssetImage('assets/placeholder.jpg'), fit: BoxFit.cover),
              ),
          ));
//    return addSymetricMargin(
//        child: Container(
//          decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.black, blurRadius: 6, spreadRadius: 1)]),
//          child: ClipRRect(
//            borderRadius: BorderRadius.circular(20),
//            child: FadeInImage(
//              fit: BoxFit.fitHeight,
////          image: NetworkImage("https://image.tmdb.org/t/p/w500/${_movie.item1.posterPath}"),
//              image: AssetImage(movie.posterPath),
//              placeholder: AssetImage('assets/placeholder.jpg'),
//            ),
//          ),
//        ));
  }
}
