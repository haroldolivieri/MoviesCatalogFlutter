import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:movies_list/src/model/movie_response.dart';
import 'package:movies_list/src/widgets/common/movie_card.dart';
import 'package:movies_list/src/widgets/common/view_utils.dart';

class FloatingMovieDetails extends StatelessWidget {
  final Color titleColor;
  final double thumbWidth;
  final double thumbHeight;
  final double parentWidth;
  final double parentHeight;
  final Movie movie;
  final double offset;

  const FloatingMovieDetails({
    Key key,
    this.titleColor,
    this.thumbHeight,
    this.movie,
    this.parentWidth,
    this.parentHeight,
    this.offset,
    this.thumbWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const TOP_SPACING = 96.0;

    return Positioned(
      width: parentWidth,
      height: parentHeight,
      top: (thumbHeight - offset > TOP_SPACING) ? thumbHeight - offset : TOP_SPACING,
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
                  tag: movie.posterPath,
                  child: MovieCard(
                    hasShadow: true,
                    urlImage: movie.posterPath,
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
                          movie.title,
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
                              movie.voteAverage.toString(),
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
    );
  }
}
