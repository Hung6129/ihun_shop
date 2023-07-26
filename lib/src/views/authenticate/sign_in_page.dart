import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ihun_shop/src/config/flutter_toast.dart';
import 'package:ihun_shop/src/config/widgets/authenticate_widgets.dart';
import 'package:ihun_shop/src/controllers/sign_in_provider.dart';

import 'package:ihun_shop/src/views/main/main_screen.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final loginNotifier = Provider.of<SignInNotifier>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 100.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              headerTitle('Welcome to', 'iHunECommerce'),
              CusTextFeild(
                onChange: (value) {
                  value = _emailController.text;
                },
                controller: _emailController,
                lblText: 'Enter your email',
                iconData: Icons.email,
              ),
              CusTextFeild(
                onChange: (value) {
                  value = _passwordController.text;
                },
                controller: _passwordController,
                lblText: 'Enter your password',
                iconData: Icons.lock,
                txtfType: 'password',
              ),
              actionBtn(() async {
                final res = await loginNotifier.userLogIn(
                    _emailController.text, _passwordController.text);
                if (res) {
                  // ignore: use_build_context_synchronously
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainScreen(),
                      ),
                      (route) => false);
                } else {
                  toastInfor(text: "Login failed");
                }
              }, 'signIn'),
              SizedBox(
                height: 10.h,
              ),
              const CusDivider(),
              const CusAuthNav(authNavType: 'signIn', navTo: '/sign_up')
            ],
          ),
        ),
      ),
    );
  }
}
