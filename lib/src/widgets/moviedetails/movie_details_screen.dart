import 'package:flutter/material.dart';
import 'package:movies_list/src/model/movie.dart';
import 'package:movies_list/src/model/change_notifiers.dart';
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
  final controller = ScrollController();
  var titleColor;
  var offset;

  @override
  void initState() {
    super.initState();
    controller.addListener(onScroll);
    titleColor = Colors.white;
    offset = 0.0;
  }

  onScroll() {
    print(offset);
    setState(() {
      offset = controller.offset;

      if (offset > 120) {
        titleColor = Colors.black;
      } else {
        titleColor = Colors.white;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final parentHeight = MediaQuery.of(context).size.height;
    final appBarHeight = parentHeight / 2.5;
    final thumbHeight = appBarHeight / 1.5;

    return ChangeNotifierProvider(
      builder: (context) => MovieNotifier(widget.movieModel),
      child: Scaffold(
          body: Stack(
        children: [
          NestedScrollView(
            physics: BouncingScrollPhysics(),
            controller: controller,
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
            body: StaticMovieDetails(offset: offset, height: thumbHeight),
          ),
          FloatingMovieDetails(
              titleColor: titleColor,
              thumbWidth: thumbHeight / 1.3,
              thumbHeight: thumbHeight,
              parentWidth: MediaQuery.of(context).size.width,
              parentHeight: parentHeight,
              offset: offset)
        ],
      )),
    );
  }

  _backgroundImage({height: double, String url}) {
    return Hero(
      tag: url,
      child: Stack(
        children: <Widget>[
          fadeNetworkImage(height: height, url: "https://image.tmdb.org/t/p/original$url"),
          Container(
            height: height,
            decoration: new BoxDecoration(color: Colors.black.withOpacity(0.5)),
          )
        ],
      ),
    );
  }
}
