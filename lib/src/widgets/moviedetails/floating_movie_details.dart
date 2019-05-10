import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:movies_list/src/model/change_notifiers.dart';
import 'package:movies_list/src/widgets/common/movie_card.dart';
import 'package:movies_list/src/widgets/common/view_utils.dart';
import 'package:provider/provider.dart';

class FloatingMovieDetails extends StatelessWidget {
  final double parentWidth;
  final double parentHeight;
  final thumbHeight;

  const FloatingMovieDetails({Key key, this.parentWidth, this.parentHeight, this.thumbHeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const TOP_SPACING = 96.0;
    
    final movie = Provider.of<MovieNotifier>(context).movie;
    final offset = Provider.of<ScrollController>(context).offset;
    final thumbWidth = thumbHeight / 1.3;
    
    var _titleColor = Colors.white;

    if (offset > 120) {
      _titleColor = Colors.black;
    } else {
      _titleColor = Colors.white;
    }

    return Positioned(
      width: parentWidth,
      height: thumbHeight,
      top: (thumbHeight - offset > TOP_SPACING) ? thumbHeight - offset : TOP_SPACING,
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 16, right: 8),
            width: thumbWidth,
            height: thumbHeight,
            child: Hero(
              tag: movie.posterPath,
              child: MovieCard(hasShadow: true),
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
                      style: textStyleMedium(fontSize: 28, color: _titleColor),
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
    );
  }
}
