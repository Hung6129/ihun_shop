import 'package:flutter/material.dart';

class FavoritesNotifier extends ChangeNotifier {
  List<dynamic> _ids = [];
  List<dynamic> _favorites = [];

  List<dynamic> get ids => _ids;

  set ids(List<dynamic> newIds) {
    _ids = newIds;
    notifyListeners();
  }

  List<dynamic> get favorites => _favorites;

  set favorites(List<dynamic> newFav) {
    _favorites = newFav;
    notifyListeners();
  }
}
