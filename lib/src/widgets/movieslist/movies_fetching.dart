import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_list/src/model/movie.dart';
import 'package:movies_list/src/widgets/common/view_utils.dart';

import '../../interactor.dart';
import 'movies_list_screen.dart';

class MoviesListRoute extends StatelessWidget {
  final MoviesInteractor interactor;

  const MoviesListRoute({this.interactor});

  @override
  Widget build(BuildContext context) {
    return withScaffold(
      body: SafeArea(
        child: Center(
          child: StreamBuilder<List<MovieModel>>(
            stream: interactor.getMovies(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError)
                return Text('Unexpected Error :(', style: textStyleMedium(fontSize: 24));
              else if (snapshot.connectionState == ConnectionState.done) {
                return MoviesListScreen(items: snapshot.data);
              } else
                return CircularProgressIndicator(backgroundColor: Colors.white);
            },
          ),
        ),
      ),
    );
  }
}
