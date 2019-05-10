import 'package:flutter/material.dart';
import 'package:movies_list/src/model/change_notifiers.dart';
import 'package:movies_list/src/widgets/common/genres_view.dart';
import 'package:movies_list/src/widgets/common/view_utils.dart';
import 'package:provider/provider.dart';

class MovieItemDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final movie = Provider.of<MovieNotifier>(context).movie;
    final page = Provider.of<PageNotifier>(context).page;
    final index = Provider.of<IndexNotifier>(context).index;

    final double distortionValue = Curves.linear.transform(distortionBasedOnPage(page, index));

    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      final titleHeight = constraints.maxHeight / 2.5;
      return Transform.scale(
        scale: distortionValue,
        child: Opacity(
            opacity: distortionValue,
            child: addMargin(
              left: 32,
              right: 32,
              child: Column(
                key: ValueKey(movie.title),
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  addMargin(
                    top: 8,
                    child: Genres(),
                  ),
                  Hero(
                    tag: movie.title,
                    child: Container(
                      height: titleHeight,
                      child: addMargin(
                        top: 8,
                        child: Text(
                          movie.title,
                          maxLines: 2,
                          style: textStyleMedium(fontSize: titleHeight / 3),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Icon(Icons.star, color: Colors.white),
                      addMargin(
                          left: 8,
                          child: Text(
                            movie.voteAverage.toString(),
                            maxLines: 2,
                            style: textStyleLight(fontSize: 25),
                          ))
                    ],
                  )
                ],
              ),
            )),
      );
    });
  }
}
