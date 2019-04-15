import 'package:flutter/material.dart';
import 'package:movies_list/src/model/movie.dart';
import 'package:movies_list/src/widgets/common/app_bar.dart';
import 'package:movies_list/src/widgets/common/view_utils.dart';

import 'movie_item_details.dart';
import 'movies_list.dart';

class MoviesListScreen extends StatefulWidget {
  final List<MovieModel> items;

  const MoviesListScreen({this.items});

  @override
  State<StatefulWidget> createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> with TickerProviderStateMixin {
  MovieModel _movieModel;
  double _page;
  int _index;
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _movieModel = widget.items[0];
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
      _movieModel = widget.items[index];
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
        backgroundImage(parentHeight: height, url: _movieModel.movie.backdropPath),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomAppBar(),
            Expanded(
                flex: 3,
                child: MoviesPageView(
                  items: widget.items,
                  onPageScrolled: onPageScrolled,
                  onPageChanged: onPageChanged,
                )),
            Expanded(
                flex: 1,
                child: MovieItemDetails(
                  page: _page,
                  index: _index,
                  movieModel: _movieModel,
                )),
          ],
        )
      ]),
    );
  }
}
