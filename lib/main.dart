import 'package:flutter/material.dart';
import 'package:movies_list/src/data/service.dart';
import 'package:movies_list/src/interactor.dart';
import 'package:movies_list/src/routes/movies_list_route.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Awesome Movies List',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primaryColor: Colors.white,
        accentColor: Colors.black,
        splashColor: Colors.white12.withOpacity(0.1),
      ),
      home: MoviesListRoute(interactor: MoviesInteractor(service: RemoteService())),
    );
  }
}
