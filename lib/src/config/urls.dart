class AppUrls {
  static const String baseUrl = "http://localhost:3108";
  static const String products = "/api/products";
  static const String searching = "/api/products/search/";
  static const String logIn = "/api/login";
  static const String signUp = "/api/register";
  static const String profile = "/api/users/";
  static const String addToCart = "/api/cart/";
  static const String getCart = "/api/cart/find/";

  static const String paymentBase =
      "paymentserver-production-7d8f.up.railway.app";
  static const String payment = "/stripe/create-checkout-session";
}
