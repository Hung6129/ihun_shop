import 'package:ihun_shop/src/config/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageServices {
  late final SharedPreferences _preferences;

  Future<StorageServices> init() async {
    _preferences = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setBool(String key, bool value) async {
    return await _preferences.setBool(key, value);
  }

  get getBool => _preferences.getBool;

  String getString(String key) {
    return _preferences.getString(key) ?? '';
  }

  Future<bool> setString(String key, String value) async {
    return await _preferences.setString(key, value);
  }

  bool getIsSignedIn() {
    return _preferences.getString(AppConstant.STORAGE_USER_TOKEN_KEY) == null
        ? false
        : true;
  }

  Future<bool> remove(String userToken) {
    return _preferences.remove(userToken);
  }

  void clear() {
    _preferences.clear();
  }
}
