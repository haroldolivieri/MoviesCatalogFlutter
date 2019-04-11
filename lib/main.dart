import 'package:flutter/material.dart';
import 'package:movies_list/src/data/service.dart';
import 'package:movies_list/src/interactor.dart';
import 'package:movies_list/src/screens/movies_fetch.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awesome Movies List',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primaryColor: Colors.white,
          splashColor: Colors.white12.withOpacity(0.1)
      ),
      home: MoviesFetch(interactor: MoviesInteractor(service: MockService())),
    );
  }
}
