import 'package:dio/dio.dart';
import 'package:ihun_shop/src/config/constants.dart';
import 'package:ihun_shop/src/config/flutter_toast.dart';
import 'package:ihun_shop/src/config/urls.dart';
import 'package:ihun_shop/src/global.dart';

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
        print(jwtToken);
        Global.storageServices
            .setString(AppConstant.STORAGE_USER_TOKEN_KEY, jwtToken);
        return true;
      } else {
        throw Exception("Failed to get sneakers list");
      }
    } catch (e) {
      toastInfor(text: e.toString());
      return false;
    }
  }
}
