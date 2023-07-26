import 'package:dio/dio.dart';
import 'package:ihun_shop/src/config/constants.dart';
import 'package:ihun_shop/src/config/flutter_toast.dart';
import 'package:ihun_shop/src/config/urls.dart';
import 'package:ihun_shop/src/global.dart';
import 'package:ihun_shop/src/models/profile_model.dart';

class AuthenHelper {
  Dio dio = Dio();

  Future<bool> logInWithEmailAndPass(String email, String password) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        toastInfor(text: "Email or password is empty");
        return false;
      } else if (!email.contains('@') || !email.contains('.')) {
        toastInfor(text: "Email is invalid");
        return false;
      } else if (password.length < 6) {
        toastInfor(text: "Password must be at least 6 characters");
        return false;
      }
      Map<String, dynamic> data = {
        "email": email,
        "password": password,
      };
      Map<String, String> headers = {"Content-Type": "application/json"};
      final response = await dio.post(
        AppUrls.baseUrl + AppUrls.logIn,
        data: data,
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        String jwtToken = response.data['token'];
        String idUser = response.data['_id'];

        Global.storageServices
            .setString(AppConstant.STORAGE_USER_TOKEN_KEY, jwtToken);
        Global.storageServices
            .setString(AppConstant.STORAGE_USER_PROFILE_KEY, idUser);
        Global.storageServices
            .setBool(AppConstant.STORAGE_USER_TOKEN_KEY, true);
        // final token = Global.storageServices
        //     .getString(AppConstant.STORAGE_USER_TOKEN_KEY);
        // final id = Global.storageServices
        //     .getString(AppConstant.STORAGE_USER_PROFILE_KEY);
        // print(token);
        // print(id);

        toastInfor(text: "Login success");
        return true;
      } else {
        toastInfor(text: "${response.data['message']}");
        return false;
      }
    } catch (e) {
      toastInfor(text: e.toString());
      return false;
    }
  }

  Future<bool> signUpWithEmailAndPassword(
    String userName,
    String email,
    String password,
    String location,
  ) async {
    try {
      if (email.isEmpty || password.isEmpty || userName.isEmpty) {
        toastInfor(text: "Email or password is empty");
        return false;
      } else if (!email.contains('@') || !email.contains('.')) {
        toastInfor(text: "Email is invalid");
        return false;
      } else if (password.length < 6) {
        toastInfor(text: "Password must be at least 6 characters");
        return false;
      }
      Map<String, dynamic> data = {
        "userName": userName,
        "email": email,
        "password": password,
        "location": location,
      };
      Map<String, String> headers = {"Content-Type": "application/json"};
      final response = await dio.post(
        AppUrls.baseUrl + AppUrls.signUp,
        data: data,
        options: Options(headers: headers),
      );
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      toastInfor(text: e.toString());
      return false;
    }
  }

  void logOut() {
    try {
      Global.storageServices.remove(AppConstant.STORAGE_USER_TOKEN_KEY);
      Global.storageServices.remove(AppConstant.STORAGE_USER_PROFILE_KEY);
      Global.storageServices.setBool(AppConstant.STORAGE_USER_TOKEN_KEY, false);
    } catch (e) {
      toastInfor(text: e.toString());
    }
  }

  Future<Profile> getProfile() async {
    final tokenUser =
        Global.storageServices.getString(AppConstant.STORAGE_USER_TOKEN_KEY);

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "token": "Bearer $tokenUser"
    };
    final response = await dio.get(
      AppUrls.baseUrl + AppUrls.profile,
      options: Options(headers: headers),
    );
    if (response.statusCode == 200) {
      final data = response.data;
      final userPro = Profile.fromMap(data);
      print(userPro);
      return userPro;
    } else {
      throw Exception("Failed to get profile");
    }
  }
}
