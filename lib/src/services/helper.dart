import 'package:dio/dio.dart';
import 'package:flutter/services.dart' as the_bundle;
import 'package:ihun_shop/src/config/urls.dart';
import 'package:ihun_shop/src/models/sneaker_model.dart';

// this class fetches data from the json file and return it to the app
class Helper {
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

  // Single Male
  Future<Sneakers> getMaleSneakersById(String id) async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/men_shoes.json");

    final maleList = sneakersFromJson(data);

    final sneaker = maleList.firstWhere((sneaker) => sneaker.id == id);

    return sneaker;
  }

  // Single Male
  Future<Sneakers> getFemaleSneakersById(String id) async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/women_shoes.json");

    final maleList = sneakersFromJson(data);

    final sneaker = maleList.firstWhere((sneaker) => sneaker.id == id);

    return sneaker;
  }

  // Single Kids
  Future<Sneakers> getKidsSneakersById(String id) async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/kids_shoes.json");

    final maleList = sneakersFromJson(data);

    final sneaker = maleList.firstWhere((sneaker) => sneaker.id == id);

    return sneaker;
  }
}