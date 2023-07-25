import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class FavoritesNotifier extends ChangeNotifier {
  final _favBox = Hive.box('fav_box');
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

  Future<void> addToFav(Map<String, dynamic> item) async {
    await _favBox.add(item);
    getFavorites();
  }

  getFavorites() {
    final favData = _favBox.keys.map((key) {
      final value = _favBox.get(key);
      return {
        'key': key,
        'id': value['id'],
      };
    }).toList();
    _favorites = favData.toList();
    _ids = _favorites.map((e) => e['id']).toList();
  }
}
