import 'package:flutter/material.dart';
import 'package:movies_list/src/model/genre.dart';

import '../view_utils.dart';

class Genres extends StatelessWidget {
  final List<Genre> genres;

  const Genres({Key key, this.genres}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final secondaryGenres = genres.where((genre) => genres.first.id != genre.id);

    String secondary = "";
    secondaryGenres.map((genre) => genre.name).toList().forEach((name) => secondary += "$name  ");

    return RichText(
      maxLines: 1,
      text: TextSpan(
        style: textStyleLight(fontSize: 16),
        children: [
          TextSpan(text: "${genres.first.name}  "),
          TextSpan(text: secondary, style: TextStyle(color: Colors.white.withOpacity(0.5)))
        ],
      ),
    );
  }
}
