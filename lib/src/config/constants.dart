import 'package:ihun_shop/src/views/authenticate/sign_in_page.dart';
import 'package:ihun_shop/src/views/favorite/favorite_page.dart';
import 'package:ihun_shop/src/views/home/home_page.dart';
import 'package:ihun_shop/src/views/profile/profile_page.dart';
import 'package:ihun_shop/src/views/search/search_page.dart';

List<dynamic> favor = [];

List<dynamic> id = [];

List pageList = [
  const HomePage(),
  const SearchPage(),
  const FavoritePage(
    autoLeading: false,
  ),
  const SignInPage()
];

class AppConstant {
  static const String STORAGE_USER_TOKEN_KEY = 'user_token_key';

  static const String STORAGE_USER_PROFILE_KEY = 'user_profile_key';
}
