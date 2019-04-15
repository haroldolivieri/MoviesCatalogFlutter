import 'package:flutter/cupertino.dart';
import 'package:movies_list/src/model/movie.dart';
import 'package:movies_list/src/widgets/common/page_view.dart';
import 'package:movies_list/src/widgets/common/view_utils.dart';

import 'movie_item.dart';

class MoviesPageView extends StatelessWidget {
  final List<MovieModel> items;
  final Function(int index) onPageChanged;
  final Function(double page) onPageScrolled;

  const MoviesPageView({
    Key key,
    @required this.items,
    this.onPageChanged,
    this.onPageScrolled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (items.length == 0)
      return Text('No Results', style: textStyleMedium(fontSize: 24));
    else {
      return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        final marginTop = 16.0;

        return addMargin(
            top: marginTop,
            child: CustomPageView(
              height: constraints.maxHeight - marginTop,
              onPageChanged: onPageChanged,
              onPageScrolled: onPageScrolled,
              children: items.map((item) {
                return addSymetricMargin(
                  horizontal: 10,
                  vertical: 5,
                  child: Hero(
                    tag: item.movie.posterPath,
                    child: MovieItem(
                      key: ValueKey(item.movie),
                      movie: item.movie,
                      genres: item.genres,
                    ),
                  ),
                );
              }).toList(),
            ));
      });
    }
  }
}
