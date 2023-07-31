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

  bool loginResponse = false;
  bool get getLoginResponse => loginResponse;
  set setLoginResponse(bool value) {
    loginResponse = value;
    notifyListeners();
  }

  bool? isLoggedIn;
  bool get getIsLoggedIn {
    isLoggedIn = Global.storageServices.getBool('isLogIn');
    return isLoggedIn ?? false;
  }

  set setIsLoggedIn(bool value) {
    isLoggedIn = value;
    notifyListeners();
  }

  bool responseBool = false;
  bool get getResponseBool => responseBool;
  set setResponseBool(bool value) {
    responseBool = value;
    notifyListeners();
  }

  Future<bool> logInWithEmailAndPass(String email, String password) async {
    setIsProcessing = true;
    bool response = await AuthenHelper().logInWithEmailAndPass(email, password);
    setIsProcessing = false;
    loginResponse = response;
    return loginResponse;
  }

  Future<bool> signUpWithEmailAndPassword(
    String userName,
    String email,
    String password,
    String location,
  ) async {
    setIsProcessing = true;
    bool response = await AuthenHelper().signUpWithEmailAndPassword(
      userName,
      email,
      password,
      location,
    );
    setIsProcessing = false;
    responseBool = response;
    return responseBool;
  }

  Future<void> logOut() async {
    Global.storageServices.clear();
    setIsLoggedIn = false;
  }
}
