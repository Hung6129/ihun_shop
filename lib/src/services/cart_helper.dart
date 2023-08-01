import 'package:dio/dio.dart';
import 'package:ihun_shop/src/config/flutter_toast.dart';

import 'package:ihun_shop/src/models/get_products.dart';

import '../config/constants.dart';
import '../config/urls.dart';
import '../global.dart';

class CartHelper {
  Dio dio = Dio();

  Future<bool> addToCart(String cartItem, int quantity) async {
    final tokenUser =
        Global.storageServices.getString(AppConstant.STORAGE_USER_TOKEN_KEY);
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "token": "Bearer $tokenUser"
    };
    final data = {
      "cartItem": cartItem,
      "quantity": quantity,
    };
    try {
      final response = await dio.post(
        AppUrls.baseUrl + AppUrls.addToCart,
        options: Options(headers: headers),
        data: data,
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      toastInfor(text: e.toString());
      return false;
    }
  }

  Future<List<Product>> getCart() async {
    final tokenUser =
        Global.storageServices.getString(AppConstant.STORAGE_USER_TOKEN_KEY);

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "token": "Bearer $tokenUser"
    };
    try {
      final response = await dio.get(
        AppUrls.baseUrl + AppUrls.getCart,
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        var data = response.data;
        List<Product> cart = [];
        var products = data[0]['products'];
        cart = List<Product>.from(products.map((x) => Product.fromJson(x)));
        return cart;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> deleteItem(String id) async {
    final tokenUser =
        Global.storageServices.getString(AppConstant.STORAGE_USER_TOKEN_KEY);
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "token": "Bearer $tokenUser"
    };
    try {
      final response = await dio.delete(
        AppUrls.baseUrl + AppUrls.addToCart + id,
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
