import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:ihun_shop/src/config/urls.dart';

import 'package:ihun_shop/src/models/sneaker_model.dart';
import 'package:ihun_shop/src/services/product_helper.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'product_helper_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  group('getMaleSneakers', () {
    final productHelper = ProductHelper();

    /// This test will pass because the http call is mocked.
    /// This test is make sure that the function will return a list of Sneakers
    test('returns a list of Sneakers if the http call completes successfully',
        () async {
      final client = MockClient();

      when(client.get(Uri.parse(AppUrls.baseUrl + AppUrls.products)))
          .thenAnswer(
        (_) async => http.Response(
          '[{"id": 1, "name": "Test"}]',
          200,
        ),
      );

      expect(await productHelper.getMaleSneakers(), isA<List<Sneakers>>());
    });

    /// This test will fail because the http call is not mocked.
    /// Try to make change url in lib/src/config/urls.dart to "CHANGE_URL_TO_FAIL_TEST"
    /// and run this test again.
    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      when(client.get(Uri.parse(AppUrls.baseUrl + AppUrls.products)))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(productHelper.getMaleSneakers(), throwsException);
    });
  });
}
