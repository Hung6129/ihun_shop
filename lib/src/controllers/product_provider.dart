import 'package:flutter/material.dart';
import 'package:ihun_shop/src/models/sneaker_model.dart';
import 'package:ihun_shop/src/services/product_helper.dart';

/// This class is a ChangeNotifier class that notifies its listeners when
/// the value of any of its properties changes.
/// ProductNotifier class is used to manage the state of the app.
/// It notifies its listeners when the user changes the page.
/// It notifies its listeners when the user selects a size.

class ProductNotifier extends ChangeNotifier {
  int _activepage = 0;
  List<dynamic> _shoeSizes = [];
  List<String> _sizes = [];

  int get activepage => _activepage;

  set activePage(int newIndex) {
    _activepage = newIndex;
    notifyListeners();
  }

  List<dynamic> get shoeSizes => _shoeSizes;

  set shoesSizes(List<dynamic> newSizes) {
    _shoeSizes = newSizes;
    notifyListeners();
  }

  ///  function is called with an index, it will toggle the selection
  /// of that item and leave the selection of all other items as they were.
  /// This will allow for multiple items to be selected at once.

  void toggleCheck(int index) {
    for (int i = 0; i < _shoeSizes.length; i++) {
      if (i == index) {
        _shoeSizes[i]['isSelected'] = !_shoeSizes[i]['isSelected'];
      }
    }
    notifyListeners();
  }

  List<String> get sizes => _sizes;

  set sizes(List<String> newSizes) {
    _sizes = newSizes;
    notifyListeners();
  }

  Future<List<Sneakers>> getMale() async {
    final male = await ProductHelper().getMaleSneakers();
    return male;
  }

  Future<List<Sneakers>> getFemale() async {
    final female = await ProductHelper().getFemaleSneakers();
    return female;
  }

  Future<List<Sneakers>> getkids() async {
    final kids = await ProductHelper().getKidsSneakers();
    return kids;
  }
}
