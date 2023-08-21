import 'package:dio/dio.dart';
import 'package:ihun_shop/src/config/urls.dart';
import 'package:ihun_shop/src/models/sneaker_model.dart';

// this class fetches data from the json file and return it to the app
class ProductHelper {
  Dio dio = Dio();

  /// This method fetches data from api and returns a list of sneakers
  /// for male category
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

  /// This method fetches data from api and returns a list of sneakers
  /// for female category
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

  /// This method fetches data from api and returns a list of sneakers
  /// for kid category
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

  /// This method fetches data from api using the search query
  /// and returns a list of sneakers
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
