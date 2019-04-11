import 'dart:ui';

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

class _MoviesListScreenState extends State<MoviesListScreen> {
  Tuple2<Movie, List<Genre>> _movie;
  double _page;
  int _index;

  @override
  void initState() {
    super.initState();
    _movie = widget.items[0];
    _page = 0;
    _index = 0;
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
    return Stack(
      children: <Widget>[
        _backgroundImage(parentHeight: height),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomAppBar(),
            Expanded(
              flex: 3,
              child: _mainContent(),
            ),
            Expanded(
              flex: 1,
              child: _movieDetails(),
            ),
          ],
        )
      ],
    );
  }

  _mainContent() {
    if (widget.items.length == 0)
      return Text('No Results', style: textStyleMedium(fontSize: 25));
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
                  vertical: 10,
                  child: MovieCard(
                    key: ValueKey(item.item1),
                    movie: item.item1,
                    genres: item.item2,
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

    return Container(
        key: ValueKey(_movie.item1.title),
        child: Transform.scale(
          scale: distortionValue,
          child: addMargin(
            left: 32,
            right: 32,
            child: Opacity(
              opacity: distortionValue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  addMargin(top: 8, child: Genres(genres: _movie.item2)),
                  addMargin(
                    top: 8,
                    child: Text(
                      _movie.item1.title,
                      style: textStyleMedium(fontSize: 25),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  _backgroundImage({parentHeight: double}) {
    //          image: NetworkImage("https://image.tmdb.org/t/p/w500/${_movie.item1.posterPath}"),
    return Stack(
      children: <Widget>[
        FadeInImage(
          key: ValueKey(_movie.item1.posterPath),
          height: parentHeight,
          fit: BoxFit.cover,
          image: AssetImage(_movie.item1.posterPath),
          placeholder: AssetImage('assets/placeholder.jpg'),
        ),
        BackdropFilter(
          filter: new ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
          child: new Container(
            height: parentHeight,
            decoration: new BoxDecoration(color: Colors.black.withOpacity(0.1)),
          ),
        )
      ],
    );
  }
}
