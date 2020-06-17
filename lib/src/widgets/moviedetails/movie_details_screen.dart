import 'package:flutter/material.dart';
import 'package:movies_list/src/model/change_notifiers.dart';
import 'package:movies_list/src/model/movie.dart';
import 'package:movies_list/src/widgets/common/view_utils.dart';
import 'package:movies_list/src/widgets/moviedetails/static_movie_details.dart';
import 'package:provider/provider.dart';

import 'floating_movie_details.dart';

class MovieDetailsScreen extends StatefulWidget {
  final MovieModel movieModel;

  const MovieDetailsScreen({Key key, this.movieModel}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MovieDetailsScreenState();
}

class MovieDetailsScreenState extends State<MovieDetailsScreen> {
  final _scrollController = ScrollController();
  
  @override
  Widget build(BuildContext context) {
    final parentHeight = MediaQuery.of(context).size.height;
    final appBarHeight = parentHeight / 2.5;
    final thumbHeight = appBarHeight / 1.5;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (context) => MovieNotifier(widget.movieModel)),
        ChangeNotifierProvider(builder: (context) => _scrollController)
      ],
      child: Scaffold(
          body: Stack(
        children: [
          NestedScrollView(
            physics: BouncingScrollPhysics(),
            controller: _scrollController,
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.blueGrey,
                  expandedHeight: appBarHeight,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    background: _backgroundImage(
                      height: parentHeight,
                      url: widget.movieModel.movie.backdropPath,
                    ),
                  ),
                )
              ];
            },
            body: StaticMovieDetails(thumbHeight: thumbHeight),
          ),
          FloatingMovieDetails(
            parentWidth: MediaQuery.of(context).size.width,
            parentHeight: parentHeight,
            thumbHeight: thumbHeight,
          )
        ],
      )),
    );
  }

  _backgroundImage({height: double, String url}) {
    return Hero(
      tag: url,
      child: Stack(
        children: <Widget>[
          fadeNetworkImage(height: height, url: url),
          Container(
            height: height,
            decoration: new BoxDecoration(color: Colors.black.withOpacity(0.2)),
          )
        ],
      ),
    );
  }
}
