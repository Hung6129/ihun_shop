import 'package:ihun_shop/src/views/home/home_page.dart';
import 'package:ihun_shop/src/views/profile/init_page.dart';
import 'package:ihun_shop/src/views/search/search_page.dart';

List pageList = [
  const HomePage(),
  const SearchPage(),
  const InitPage(),
];

class AppConstant {
  static const String STORAGE_USER_TOKEN_KEY = 'user_token_key';

  static const String STORAGE_USER_PROFILE_KEY = 'user_profile_key';

  static const String defaultImageProfile =
      'https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fHByb2ZpbGV8ZW58MHwxfDB8fHww&auto=format&fit=crop&w=800&q=60';
}
