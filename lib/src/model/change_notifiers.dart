import 'package:flutter/foundation.dart';

import 'movie.dart';

class MovieNotifier with ChangeNotifier {
    MovieModel _movieModel;
    
    MovieNotifier(
        MovieModel item
        ) {
        _movieModel = item;
    }
    
    get movie => _movieModel.movie;
    
    get genres => _movieModel.genres;
    
    set movieModel(
        MovieModel newMovie
        ) {
        _movieModel = newMovie;
        notifyListeners();
    }
}

class PageNotifier with ChangeNotifier {
    double _page = 0.0;
    
    get page => _page;
    
    set page(
        double newPage
        ) {
        _page = newPage;
        notifyListeners();
    }
}

class IndexNotifier with ChangeNotifier {
    int _index = 0;
    
    get index => _index;
    
    set index(
        int newIdex
        ) {
        _index = newIdex;
        notifyListeners();
    }
}