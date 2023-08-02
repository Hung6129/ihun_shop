import 'dart:convert';

import 'package:ihun_shop/src/config/urls.dart';
import 'package:ihun_shop/src/models/orders_req.dart';
import 'package:http/http.dart' as http;

class PaymentHelper {
  final client = http.Client();
  Future<String> makePayment(Order model) async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    var data = jsonEncode(model.toJson());
    final url = Uri.https(AppUrls.paymentBase, AppUrls.payment);

    final response = await client.post(
      url,
      headers: headers,
      body: data,
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      var payment = jsonDecode(response.body);
      return payment['url'];
    } else {
      return 'failed';
    }
  }
}
