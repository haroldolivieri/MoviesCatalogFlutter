import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movies_list/src/model/movie.dart';
import 'package:movies_list/src/model/change_notifiers.dart';
import 'package:movies_list/src/widgets/common/app_bar.dart';
import 'package:movies_list/src/widgets/common/view_utils.dart';
import 'package:provider/provider.dart';

import 'movie_item_details.dart';
import 'movies_page_view.dart';

class MoviesListScreen extends StatefulWidget {
  final List<MovieModel> items;

  const MoviesListScreen({this.items});

  @override
  State<StatefulWidget> createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      lowerBound: 0.8,
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    animation = CurvedAnimation(parent: controller, curve: Curves.ease);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (context) => MovieNotifier(widget.items[0])),
        ChangeNotifierProvider(builder: (context) => PageNotifier()),
        ChangeNotifierProvider(builder: (context) => IndexNotifier()),
      ],
      child: ScaleTransition(
        scale: animation,
        child: Stack(children: <Widget>[
          backgroundImage(height: height),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomAppBar(),
              Expanded(
                flex: 3,
                child: MoviesPageView(items: widget.items),
              ),
              Expanded(
                flex: 1,
                child: MovieItemDetails(),
              ),
            ],
          )
        ]),
      ),
    );
  }

  backgroundImage({height: double, String url}) {
    return Consumer<MovieNotifier>(
      builder: (context, notifier, _) => Hero(
            tag: notifier.movie.id,
            child: Stack(
              children: <Widget>[
                fadeNetworkImage(
                  height: height,
                  url: "https://image.tmdb.org/t/p/w200${notifier.movie.backdropPath}",
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
                  child: Container(
                    height: height,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                )
              ],
            ),
          ),
    );
  }
}
