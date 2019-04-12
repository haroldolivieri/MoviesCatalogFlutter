import 'package:flutter/material.dart';
import 'package:movies_list/src/model/genre.dart';
import 'package:movies_list/src/model/movie.dart';
import 'package:movies_list/src/widgets/custom_app_bar.dart';
import 'package:movies_list/src/widgets/custom_page_view.dart';
import 'package:movies_list/src/widgets/genres_list.dart';
import 'package:movies_list/src/widgets/movie_card.dart';
import 'package:tuple/tuple.dart';

import '../view_utils.dart';

class MoviesListScreen extends StatefulWidget {
  final List<Tuple2<Movie, List<Genre>>> items;

  const MoviesListScreen({this.items});

  @override
  State<StatefulWidget> createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> with TickerProviderStateMixin {
  Tuple2<Movie, List<Genre>> _movie;
  double _page;
  int _index;
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _movie = widget.items[0];
    _page = 0;
    _index = 0;

    controller = AnimationController(
      lowerBound: 0.8,
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    animation = CurvedAnimation(parent: controller, curve: Curves.ease);
    controller.forward();
  }

  void onPageChanged(int index) {
    setState(() {
      _index = index;
      _movie = widget.items[index];
    });
  }

  void onPageScrolled(double page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return ScaleTransition(
      scale: animation,
      child: Stack(children: <Widget>[
        backgroundImage(parentHeight: height, url: _movie.item1.backdropPath),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomAppBar(),
            Expanded(flex: 3, child: _mainContent()),
            Expanded(flex: 1, child: _movieDetails()),
          ],
        )
      ]),
    );
  }

  _mainContent() {
    if (widget.items.length == 0)
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
              children: widget.items.map((item) {
                return addSymetricMargin(
                  horizontal: 10,
                  vertical: 5,
                  child: Hero(
                    tag: item.item1.posterPath,
                    child: MovieItem(
                      key: ValueKey(item.item1),
                      movie: item.item1,
                      genres: item.item2
                    ),
                  ),
                );
              }).toList(),
            ));
      });
    }
  }

  _movieDetails() {
    final diffPosition = _page - _index;
    double normalizedDistortion = (FULL_SCALE - (diffPosition.abs() * SCALE_FRACTION)).clamp(0.0, 1.0);
    final double distortionValue = Curves.linear.transform(normalizedDistortion);

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
                key: ValueKey(_movie.item1.title),
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  addMargin(
                    top: 8,
                    child: Genres(genres: _movie.item2),
                  ),
                  Hero(
                    tag: _movie.item1.title,
                    child: Container(
                      height: titleHeight,
                      child: addMargin(
                        top: 8,
                        child: Text(
                          _movie.item1.title,
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
                          child: Text(_movie.item1.voteAverage.toString(),
                              maxLines: 2, style: textStyleLight(fontSize: 25)))
                    ],
                  )
                ],
              ),
            )),
      );
    });
  }
}