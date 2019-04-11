import 'package:flutter/cupertino.dart';
import 'package:movies_list/src/model/movie.dart';

class MovieDetails extends StatefulWidget {
 
  final Movie movie;

  const MovieDetails({Key key, this.movie}) : super(key: key);
  
  @override
  State<StatefulWidget> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}
