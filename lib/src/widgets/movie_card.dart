import 'package:flutter/material.dart';
import 'package:movies_list/src/model/genre.dart';
import 'package:movies_list/src/model/movie.dart';
import 'package:movies_list/src/routes/move_details_route.dart';
import 'package:movies_list/src/view_utils.dart';

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
          builder: (context) => MovieDetailsRoute(
                movie: widget.movie,
                genres: widget.genres,
              )),
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
                urlImage: widget.movie.posterPath,
                radius: 20,
                hasShadow: true,
              ),
            ),
          ),
        ));
  }
}

class MovieCard extends StatelessWidget {
  final String urlImage;
  final double radius;
  final bool hasShadow;

  const MovieCard({Key key, this.urlImage, this.radius = 0, this.hasShadow = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: hasShadow ? Colors.black : Colors.transparent,
            blurRadius: 6,
            spreadRadius: 1,
          )
        ],
        borderRadius: new BorderRadius.circular(radius),
        image: DecorationImage(
          image: NetworkImage("https://image.tmdb.org/t/p/w500$urlImage"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
