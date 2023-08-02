import 'package:flutter/material.dart';

class PaymentNotifier extends ChangeNotifier {
  String? paymentUrl;
  String get getPaymentUrl => paymentUrl ?? "";
  set setPaymentUrl(String url) {
    paymentUrl = url;
    notifyListeners();
  }
}
