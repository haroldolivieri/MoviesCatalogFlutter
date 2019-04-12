import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:movies_list/src/model/genre.dart';
import 'package:movies_list/src/model/movie.dart';
import 'package:movies_list/src/widgets/genres_list.dart';
import 'package:movies_list/src/widgets/movie_card.dart';

import '../view_utils.dart';

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
    final parentWidth = MediaQuery.of(context).size.width;
    final appBarHeight = parentHeight / 2.5;
    final thumbHeight = appBarHeight / 1.5;
    final thumbWidth = thumbHeight / 1.3;

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
                  background: backgroundImageNotBlured(
                    parentHeight: parentHeight,
                    url: widget.movie.backdropPath,
                  ),
                ),
              )
            ];
          },
          body: Transform.translate(
            offset: Offset(0, offset * 0.7),
            child: Padding(
              padding: const EdgeInsets.only(left:24, right: 24),
              child: Container(
                margin: EdgeInsets.only(top: thumbHeight * 0.6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Genres(genres: widget.genres, color: Colors.black),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                          widget.movie.overview,
                          style: textStyleRegular(fontSize: 16, color: Colors.blueGrey),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          width: parentWidth,
          height: parentHeight,
          top: (thumbHeight - offset > 96) ? thumbHeight - offset : 96,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 16, right: 8),
                    width: thumbWidth,
                    height: thumbHeight,
                    child: Hero(
                      tag: widget.movie.posterPath,
                      child: MovieCard(
                        hasShadow: true,
                        urlImage: widget.movie.posterPath,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            height: thumbHeight / 1.4,
                            child: AutoSizeText(
                              widget.movie.title,
                              maxLines: 3,
                              minFontSize: 22,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style: textStyleMedium(fontSize: 28, color: titleColor),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Icon(
                                  Icons.star,
                                  color: Colors.blueGrey,
                                ),
                              ),
                              Container(
                                child: AutoSizeText(
                                  widget.movie.voteAverage.toString(),
                                  textAlign: TextAlign.end,
                                  maxLines: 1,
                                  style: textStyleMedium(fontSize: 30, color: Colors.blueGrey),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    ));
  }
}
