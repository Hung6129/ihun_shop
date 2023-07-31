import 'package:ihun_shop/src/views/favorite/favorite_page.dart';
import 'package:ihun_shop/src/views/home/home_page.dart';
import 'package:ihun_shop/src/views/profile/init_page.dart';

import 'package:ihun_shop/src/views/search/search_page.dart';

List pageList = [
  const HomePage(),
  const SearchPage(),
  const FavoritePage(
    autoLeading: false,
  ),
  const InitPage(),
];

class AppConstant {
  static const String STORAGE_USER_TOKEN_KEY = 'user_token_key';

  static const String STORAGE_USER_PROFILE_KEY = 'user_profile_key';
}
