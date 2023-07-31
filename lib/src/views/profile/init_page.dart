import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ihun_shop/src/controllers/authen_provider.dart';
import 'package:ihun_shop/src/views/authenticate/sign_in_page.dart';
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
                Center(
                  child: CircleAvatar(
                    radius: 50.h,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "User Name",
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on),
                    Text("Location"),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const ListTile(
                  leading: Icon(Icons.person),
                  title: Text("Profile"),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                const ListTile(
                  leading: Icon(Icons.shopping_cart),
                  title: Text("My Order"),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                const ListTile(
                  leading: Icon(Icons.settings),
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
                  leading: const Icon(Icons.logout),
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
