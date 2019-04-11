import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_list/src/model/genre.dart';
import 'package:movies_list/src/model/movie.dart';
import 'package:tuple/tuple.dart';

import '../interactor.dart';
import '../view_utils.dart';
import 'movies_list_screen.dart';

class MoviesFetch extends StatefulWidget {
  final MoviesInteractor interactor;

  const MoviesFetch({this.interactor});

  @override
  _MoviesFetchState createState() => _MoviesFetchState();
}

class _MoviesFetchState extends State<MoviesFetch> {
  @override
  Widget build(BuildContext context) {
    return withScaffold(
      title: 'Movies',
      body: SafeArea(
        child: Center(
          child: StreamBuilder<List<Tuple2<Movie, List<Genre>>>>(
            stream: widget.interactor.getMovies(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError)
                return Text('Unexpected Error');
              else if (snapshot.connectionState == ConnectionState.done)
                return MoviesListScreen(items: snapshot.data);
              else
                return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
