import 'package:flutter/material.dart';
import 'package:ihun_shop/src/global.dart';
import 'package:ihun_shop/src/services/authen_helper.dart';

class AuthNotifier extends ChangeNotifier {
  bool isProcessing = false;
  bool get getIsProcessing => isProcessing;
  set setIsProcessing(bool value) {
    isProcessing = value;
    notifyListeners();
  }

  bool checkIsLoggedIn() {
    final value = Global.storageServices.getIsSignedIn();
    setIsLoggedIn = value;
    return isLoggedIn;
  }

  bool isLoggedIn = false;
  bool get getIsLoggedIn => isLoggedIn;
  set setIsLoggedIn(bool value) {
    isLoggedIn = value;
    notifyListeners();
  }

  Future<bool> userLogIn(String email, String password) async {
    setIsProcessing = true;
    bool res = await AuthenHelper().logInWithEmailAndPass(email, password);
    setIsProcessing = false;
    setIsLoggedIn = res;
    return isLoggedIn;
  }

  Future<bool> userLogOut() async {
    setIsProcessing = true;
    final res = AuthenHelper().logOut();
    setIsProcessing = false;
    setIsLoggedIn = !res;
    return isLoggedIn;
  }
}
