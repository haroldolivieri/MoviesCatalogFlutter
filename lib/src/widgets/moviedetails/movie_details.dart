import 'package:flutter/material.dart';
import 'package:movies_list/src/model/genre_response.dart';
import 'package:movies_list/src/model/movie_response.dart';
import 'package:movies_list/src/widgets/common/view_utils.dart';
import 'package:movies_list/src/widgets/moviedetails/static_movie_details.dart';

import 'floating_movie_details.dart';

class MovieDetailsRoute extends StatefulWidget {
  final Movie movie;
  final List<Genre> genres;

  const MovieDetailsRoute({this.movie, this.genres});

  @override
  State<StatefulWidget> createState() => MovieDetailsRouteState();
}

class MovieDetailsRouteState extends State<MovieDetailsRoute> {
  final controller = ScrollController();
  var titleColor;
  var offset;

  @override
  void initState() {
    super.initState();
    controller.addListener(onScroll);
    titleColor = Colors.white;
    offset = 0.0;
  }

  onScroll() {
    print(offset);
    setState(() {
      offset = controller.offset;

      if (offset > 120) {
        titleColor = Colors.black;
      } else {
        titleColor = Colors.white;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final parentHeight = MediaQuery.of(context).size.height;
    final appBarHeight = parentHeight / 2.5;
    final thumbHeight = appBarHeight / 1.5;

    return Scaffold(
        body: Stack(
      children: [
        NestedScrollView(
          physics: BouncingScrollPhysics(),
          controller: controller,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Colors.blueGrey,
                expandedHeight: appBarHeight,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background: _backgroundImage(
                    height: parentHeight,
                    url: widget.movie.backdropPath,
                  ),
                ),
              )
            ];
          },
          body: StaticMovieDetails(
            offset: offset,
            height: thumbHeight,
            genres: widget.genres,
            movie: widget.movie,
          ),
        ),
        FloatingMovieDetails(
            titleColor: titleColor,
            thumbWidth: thumbHeight / 1.3,
            thumbHeight: thumbHeight,
            parentWidth: MediaQuery.of(context).size.width,
            parentHeight: parentHeight,
            movie: widget.movie,
            offset: offset)
      ],
    ));
  }

  _backgroundImage({height: double, String url}) {
    return Hero(
      tag: url,
      child: Stack(
        children: <Widget>[
          fadeNetworkImage(height: height, url: "https://image.tmdb.org/t/p/original$url"),
          Container(
            height: height,
            decoration: new BoxDecoration(color: Colors.black.withOpacity(0.5)),
          )
        ],
      ),
    );
  }
}
