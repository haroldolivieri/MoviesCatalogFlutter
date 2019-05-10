import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_list/src/data/movies_bloc.dart';
import 'package:movies_list/src/model/movie.dart';
import 'package:movies_list/src/widgets/common/view_utils.dart';
import 'package:provider/provider.dart';

import 'movies_list_screen.dart';

class MoviesFetching extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  
    final moviesBloc = Provider.of<MoviesBloc>(context);
    
    return withScaffold(
      body: SafeArea(
        child: Center(
          child: StreamBuilder<List<MovieModel>>(
            stream: moviesBloc.getMovies(),
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
