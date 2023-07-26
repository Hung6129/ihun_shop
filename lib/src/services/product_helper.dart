import 'package:dio/dio.dart';
import 'package:ihun_shop/src/config/urls.dart';
import 'package:ihun_shop/src/models/sneaker_model.dart';

// this class fetches data from the json file and return it to the app
class ProductHelper {
  Dio dio = Dio();
  // Male
  Future<List<Sneakers>> getMaleSneakers() async {
    final response = await dio.get(AppUrls.baseUrl + AppUrls.products);
    if (response.statusCode == 200) {
      final data = response.data as List<dynamic>;
      final products = data.map((e) => Sneakers.fromMap(e)).toList();
      final maleProducts = products
          .where((element) => element.category == "Men's Shoes")
          .toList();
      return maleProducts;
    } else {
      throw Exception("Failed to get sneakers list");
    }
  }

// Female
  Future<List<Sneakers>> getFemaleSneakers() async {
    final response = await dio.get(AppUrls.baseUrl + AppUrls.products);
    if (response.statusCode == 200) {
      final data = response.data as List<dynamic>;
      final products = data.map((e) => Sneakers.fromMap(e)).toList();
      final womanProducts = products
          .where((element) => element.category == "Women's Shoes")
          .toList();
      return womanProducts;
    } else {
      throw Exception("Failed to get sneakers list");
    }
  }

// Kids
  Future<List<Sneakers>> getKidsSneakers() async {
    final response = await dio.get(AppUrls.baseUrl + AppUrls.products);
    if (response.statusCode == 200) {
      final data = response.data as List<dynamic>;
      final products = data.map((e) => Sneakers.fromMap(e)).toList();
      final kidProducts = products
          .where((element) => element.category == "Kids' Shoes")
          .toList();
      return kidProducts;
    } else {
      throw Exception("Failed to get sneakers list");
    }
  }

// Searching
  Future<List<Sneakers>> searchingProducts(String query) async {
    final response = await dio.get(AppUrls.baseUrl + AppUrls.searching + query);
    if (response.statusCode == 200) {
      final data = response.data as List<dynamic>;
      final products = data.map((e) => Sneakers.fromMap(e)).toList();
      return products;
    } else {
      throw Exception("Failed to get sneakers list");
    }
  }
}
