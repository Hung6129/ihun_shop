import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ihun_shop/src/config/flutter_toast.dart';
import 'package:ihun_shop/src/config/widgets/authenticate_widgets.dart';
import 'package:provider/provider.dart';

import '../../controllers/authen_provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _reTypePasswordController =
      TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authNotifier = Provider.of<AuthNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 18.w,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              headerTitle('Sign up to enter', 'iHun Shop'),
              CusTextFeild(
                  onChange: (value) {
                    value = _usernameController.text;
                  },
                  controller: _usernameController,
                  lblText: 'Enter your username',
                  iconData: Icons.person),
              CusTextFeild(
                  onChange: (value) {
                    value = _emailController.text;
                  },
                  controller: _emailController,
                  lblText: 'Enter your email',
                  iconData: Icons.email_rounded),
              CusTextFeild(
                  onChange: (value) {
                    value = _passwordController.text;
                  },
                  controller: _passwordController,
                  lblText: 'Enter your passwod',
                  txtfType: 'password',
                  iconData: Icons.password_rounded),
              CusTextFeild(
                  onChange: (value) {
                    value = _reTypePasswordController.text;
                  },
                  controller: _reTypePasswordController,
                  lblText: 'Retype your passwod',
                  txtfType: 'password',
                  iconData: Icons.password_rounded),
              CusTextFeild(
                  onChange: (value) {
                    value = _locationController.text;
                  },
                  controller: _locationController,
                  lblText: 'Enter your location, default is Ho Chi Minh City',
                  iconData: Icons.location_on_rounded),
              SizedBox(
                height: 20.h,
              ),
              actionBtn(() {
                if (_locationController.text.isEmpty) {
                  _locationController.text = 'Ho Chi Minh City';
                }
                authNotifier
                    .signUpWithEmailAndPassword(
                  _usernameController.text,
                  _emailController.text,
                  _passwordController.text,
                  _locationController.text,
                )
                    .then((response) {
                  if (response) {
                    toastInfor(text: 'Signup success');
                    Navigator.pop(context);
                  } else {
                    toastInfor(text: 'Signup failed');
                  }
                });
              }, ''),
              ForgotPassword(
                ontap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
