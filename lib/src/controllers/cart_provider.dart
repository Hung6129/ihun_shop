import 'package:flutter/material.dart';
import 'package:ihun_shop/src/models/get_products.dart';

class CartNotifier extends ChangeNotifier {
  List<Product> _checkout = [];

  List<Product> get checkout => _checkout;
  set checkout(List<Product> checkout) {
    _checkout = checkout;
    notifyListeners();
  }

  int? _productIndex;
  int? get productIndex => _productIndex ?? 0;
  set productIndex(int? productIndex) {
    _productIndex = productIndex;
    notifyListeners();
  }

  // Future<bool> addToCart(String cartItem, int quantity) async {
  //   final res = await CartHelper().addToCart(cartItem, quantity);
  //   if (res == true) {
  //     notifyListeners();
  //   }
  //   return res;
  // }

  // Future<List<Product>> getCart() async {
  //   final res = await CartHelper().getCart();
  //   return res;
  // }

  // Future<bool> deleteCartItem(String id) async {
  //   final res = await CartHelper().deleteItem(id);
  //   if (res == true) {
  //     notifyListeners();
  //   }
  //   return res;
  // }
}
