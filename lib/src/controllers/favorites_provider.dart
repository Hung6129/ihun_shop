import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class FavoritesNotifier extends ChangeNotifier {
  final _favBox = Hive.box('fav_box');
  List<dynamic> _ids = [];
  List<dynamic> _favorites = [];

  List<dynamic> _fav = [];

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

  List<dynamic> get fav => _fav;

  set fav(List<dynamic> newIds) {
    _fav = newIds;
    notifyListeners();
  }

  getAllData() {
    final data = _favBox.keys.map((e) {
      final item = _favBox.get(e);
      return {
        'key': e,
        'id': item['id'],
        'name': item['name'],
        'category': item['category'],
        'imageUrl': item['imageUrl'],
        'price': item['price'],
      };
    }).toList();
    _fav = data.reversed.toList();
  }

  Future<void> addToFav(Map<String, dynamic> item) async {
    await _favBox.add(item);
    getFavorites();
    notifyListeners();
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

  Future<void> removeFromFav(int key) async {
    await _favBox.delete(key);
    notifyListeners();
  }
}
