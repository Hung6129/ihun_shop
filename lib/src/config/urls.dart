class AppUrls {
  /// This is the base url for the api
  static const String baseUrl = "http://localhost:3108";

  /// Api for fetching products
  static const String products = "/api/products";

  /// Api for searching products using query
  static const String searching = "/api/products/search/";

  /// Api for authentication and resigtration of user
  static const String logIn = "/api/login";
  static const String signUp = "/api/register";
  static const String profile = "/api/users/";

  /// Api for adding product to cart and fetching cart items
  static const String addToCart = "/api/cart/";
  static const String getCart = "/api/cart/find/";

  static const String paymentBase = "Your payment base url";
  static const String payment = "/api/payment";
}
