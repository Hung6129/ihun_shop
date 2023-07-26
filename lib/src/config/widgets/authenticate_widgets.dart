import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ihun_shop/src/config/styles/palettes.dart';
import 'package:ihun_shop/src/config/styles/text_styles.dart';
import 'package:ihun_shop/src/views/authenticate/sign_in_page.dart';
import 'package:ihun_shop/src/views/authenticate/sign_up_page.dart';

class CusAuthNav extends StatelessWidget {
  const CusAuthNav({
    super.key,
    required this.authNavType,
    required this.navTo,
  });

  final String authNavType;
  final String navTo;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: authNavType == 'signIn'
                ? 'Do not have account yet? '
                : 'Already have account? ',
            style: TextStyles.defaultStyle,
          ),
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return navTo == 'signIn'
                          ? const SignInPage()
                          : const SignUpPage();
                    },
                  ),
                );
              },
            text: authNavType == 'signIn' ? ' Sign up here ' : ' Sign in here',
            style: TextStyles.defaultStyle.bold.setTextSize(15.sp),
          ),
        ],
      ),
    );
  }
}

class CusDivider extends StatelessWidget {
  const CusDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.w),
      child: Divider(
        indent: 20.w,
        endIndent: 20.w,
        thickness: 1,
      ),
    );
  }
}

class CusTextFeild extends StatelessWidget {
  const CusTextFeild({
    super.key,
    required this.controller,
    required this.lblText,
    required this.iconData,
    this.txtfType = 'text',
    required this.onChange,
  });
  final Function(String value) onChange;
  final String txtfType;
  final TextEditingController controller;
  final String lblText;
  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: TextField(
        onChanged: onChange,
        controller: controller,
        obscureText: txtfType == 'password' ? true : false,
        decoration: InputDecoration(
          prefixIcon: Icon(iconData),
          suffixIcon: ClearButton(controller: controller),
          labelText: lblText,
          labelStyle: TextStyles.customStyle,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

class ClearButton extends StatelessWidget {
  const ClearButton({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) => IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          controller.clear();
        },
      );
}

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({
    super.key,
    required this.ontap,
  });

  final VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.h),
      child: GestureDetector(
        onTap: ontap,
        child:
            Text("Forgot password?", style: TextStyles.defaultStyle.underLine),
      ),
    );
  }
}

Widget headerTitle(String text1, String text2) {
  return Column(
    children: [
      Text(
        text1,
        style: TextStyles.defaultStyle,
      ),
      Text(
        text2,
        style: TextStyles.customStyle.appTitle,
      ),
    ],
  );
}

Widget otherSignIn() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
    child: Text(
      'Or sign in with',
      style: TextStyles.defaultStyle,
    ),
  );
}

Widget actionBtn(VoidCallback action, String type) {
  return ElevatedButton.icon(
    style: const ButtonStyle(
      backgroundColor: MaterialStatePropertyAll<Color>(Palettes.p3),
    ),
    onPressed: action,
    icon: type == 'signIn'
        ? const Icon(
            Icons.login_rounded,
            color: Palettes.textWhite,
          )
        : const Icon(
            Icons.waves_rounded,
            color: Palettes.textWhite,
          ),
    label: Text(
      type == 'signIn' ? 'Sign In' : 'Sign Up',
      style: TextStyles.customStyle.whiteText.bold,
    ),
  );
}
