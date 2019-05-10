import 'package:flutter/material.dart';
import 'package:movies_list/src/model/genre_response.dart';
import 'package:movies_list/src/model/movie.dart';
import 'package:movies_list/src/model/movie_response.dart';
import 'package:movies_list/src/widgets/common/movie_card.dart';
import 'package:movies_list/src/widgets/common/view_utils.dart';
import 'package:movies_list/src/widgets/moviedetails/movie_details_screen.dart';

class MovieItem extends StatefulWidget {
  final Movie movie;
  final List<Genre> genres;

  const MovieItem({Key key, this.movie, this.genres}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MovieItemState();
}

class MovieItemState extends State<MovieItem> with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: 0.1,
    );
    _animationController.addListener(() {
      setState(() {});
    });
  }

  void _onTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MovieDetailsScreen(
                  movieModel: MovieModel(
                movie: widget.movie,
                genres: widget.genres,
              ))),
    );
  }

  @override
  Widget build(BuildContext context) {
    double scale = 1 - _animationController.value;
    return addSymetricMargin(
        horizontal: 5,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _onTap,
            child: Transform.scale(
              scale: scale,
              child: MovieCard(
                urlImage: widget.movie.backdropPath,
                radius: 20,
                hasShadow: true,
              ),
            ),
          ),
        ));
  }
}
