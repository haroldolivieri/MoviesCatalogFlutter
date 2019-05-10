import 'package:flutter/material.dart';
import 'package:movies_list/src/model/change_notifiers.dart';
import 'package:movies_list/src/widgets/common/view_utils.dart';
import 'package:provider/provider.dart';

class Genres extends StatelessWidget {
  final color;

  const Genres({Key key, this.color = Colors.white}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final genres = Provider.of<MovieNotifier>(context).genres;
    final secondaryGenres = genres.where((genre) => genres.first.id != genre.id);

    String secondary = "";
    secondaryGenres.map((genre) => genre.name).toList().forEach((name) => secondary += "$name  ");

    return RichText(
      maxLines: 1,
      text: TextSpan(
        style: textStyleLight(fontSize: 16, color: color),
        children: [
          TextSpan(text: "${genres.first.name}  "),
          TextSpan(text: secondary, style: TextStyle(color: color.withOpacity(0.5)))
        ],
      ),
    );
  }
}
