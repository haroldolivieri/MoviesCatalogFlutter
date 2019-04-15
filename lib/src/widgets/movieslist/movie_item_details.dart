import 'package:flutter/material.dart';
import 'package:movies_list/src/model/movie.dart';
import 'package:movies_list/src/widgets/common/genres_view.dart';
import 'package:movies_list/src/widgets/common/view_utils.dart';

class MovieItemDetails extends StatelessWidget {
  final MovieModel movieModel;
  final double page;
  final int index;

  const MovieItemDetails({
    Key key,
    @required this.page,
    @required this.index,
    @required this.movieModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                key: ValueKey(movieModel.movie.title),
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  addMargin(
                    top: 8,
                    child: Genres(genres: movieModel.genres),
                  ),
                  Hero(
                    tag: movieModel.movie.title,
                    child: Container(
                      height: titleHeight,
                      child: addMargin(
                        top: 8,
                        child: Text(
                          movieModel.movie.title,
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
                            movieModel.movie.voteAverage.toString(),
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
