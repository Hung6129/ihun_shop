import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ihun_shop/src/config/constants.dart';
import 'package:ihun_shop/src/config/styles/text_styles.dart';
import 'package:ihun_shop/src/controllers/authen_provider.dart';
import 'package:ihun_shop/src/models/profile_model.dart';
import 'package:ihun_shop/src/services/authen_helper.dart';
import 'package:ihun_shop/src/views/authenticate/sign_in_page.dart';
import 'package:ihun_shop/src/views/cart/cart_page.dart';
import 'package:ihun_shop/src/views/favorite/favorite_page.dart';
import 'package:provider/provider.dart';

class InitPage extends StatelessWidget {
  const InitPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authNotifier = Provider.of<AuthNotifier>(context);
    return authNotifier.getIsLoggedIn == true
        ? Scaffold(
            body: Column(
              children: [
                SizedBox(
                  height: 80.h,
                ),
                CircleAvatar(
                  radius: 50.h,
                  backgroundImage:
                      const NetworkImage(AppConstant.defaultImageProfile),
                ),
                FutureBuilder<Profile>(
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final profile = snapshot.data;
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              profile!.userName,
                              style: TextStyles.defaultStyle.bold
                                  .setTextSize(20.sp),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.location_on),
                              SizedBox(
                                width: 8.h,
                              ),
                              Text(profile.location),
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.email_rounded),
                              SizedBox(
                                width: 8.h,
                              ),
                              Text(profile.email),
                            ],
                          ),
                        ],
                      );
                    }
                    if (snapshot.hasError) {
                      return const Text("Error");
                    } else {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                  },
                  future: AuthenHelper().getProfile(),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const CartPage();
                        },
                      ),
                    );
                  },
                  leading: const Icon(
                    Icons.shopping_bag,
                    color: Colors.black,
                  ),
                  title: const Text("My Order"),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const FavoritePage(
                            autoLeading: true,
                          );
                        },
                      ),
                    );
                  },
                  leading: const Icon(CupertinoIcons.square_favorites_alt_fill,
                      color: Colors.black),
                  title: const Text("My Favorite"),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
                const ListTile(
                  leading: Icon(Icons.settings, color: Colors.black),
                  title: Text("Settings"),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                Divider(
                  indent: 20.w,
                  endIndent: 20.w,
                  thickness: 2,
                ),
                ListTile(
                  onTap: () {
                    authNotifier.logOut();
                  },
                  leading: const Icon(Icons.logout, color: Colors.black),
                  title: const Text("Log out"),
                  trailing: const Icon(Icons.arrow_forward_ios),
                )
              ],
            ),
          )
        : Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "You haven't logged in yet.",
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const SignInPage();
                          },
                          fullscreenDialog: true,
                        ),
                      );
                    },
                    child: const Text("Login here"),
                  )
                ],
              ),
            ),
          );
  }
}
