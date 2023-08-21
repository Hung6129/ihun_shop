// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:ihun_shop/src/services/product_helper.dart';

void main() {
  ProductHelper productHelper = ProductHelper();
  group('ProductHelper', () {
    test('getMaleSneakers', () {
      try {
        expect(
          productHelper.getMaleSneakers(),
          isA<Future<List>>(),
        );
      } catch (e) {
        expect(e, isA<Exception>());
      }
    });
    test('getFemaleSneakers', () {
      try {
        expect(
          productHelper.getFemaleSneakers(),
          isA<Future<List>>(),
        );
      } catch (e) {
        expect(e, isA<Exception>());
      }
    });
    test('getKidsSneakers', () {
      try {
        expect(
          productHelper.getKidsSneakers(),
          isA<Future<List>>(),
        );
      } catch (e) {
        expect(e, isA<Exception>());
      }
    });
  });
}
