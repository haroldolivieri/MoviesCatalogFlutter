import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_list/src/model/change_notifiers.dart';
import 'package:movies_list/src/widgets/common/genres_view.dart';
import 'package:movies_list/src/widgets/common/view_utils.dart';
import 'package:provider/provider.dart';

class StaticMovieDetails extends StatelessWidget {
  final thumbHeight;

  const StaticMovieDetails({Key key, this.thumbHeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movie = Provider.of<MovieNotifier>(context).movie;
    final offset = Provider.of<ScrollController>(context).offset;

    return Transform.translate(
      offset: Offset(0, offset * 0.7),
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: Container(
          margin: EdgeInsets.only(top: thumbHeight * 0.6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Genres(color: Colors.black),
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
