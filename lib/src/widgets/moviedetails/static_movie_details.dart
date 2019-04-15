import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_list/src/model/genre_response.dart';
import 'package:movies_list/src/model/movie_response.dart';
import 'package:movies_list/src/widgets/common/genres_view.dart';
import 'package:movies_list/src/widgets/common/view_utils.dart';

class StaticMovieDetails extends StatelessWidget {
  final double offset;
  final double height;
  final Movie movie;
  final List<Genre> genres;

  const StaticMovieDetails({
    Key key,
    this.offset,
    this.height,
    @required this.movie,
    @required this.genres,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("FILME => $movie");
    return Transform.translate(
      offset: Offset(0, offset * 0.7),
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: Container(
          margin: EdgeInsets.only(top: height * 0.6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Genres(genres: genres, color: Colors.black),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    movie.overview,
                    style: textStyleRegular(fontSize: 16, color: Colors.blueGrey),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
