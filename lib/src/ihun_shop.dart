import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ihun_shop/src/controllers/mainscreen_provider.dart';
import 'package:ihun_shop/src/controllers/product_provider.dart';
import 'package:provider/provider.dart';

import 'controllers/authen_provider.dart';
import 'controllers/cart_provider.dart';
import 'controllers/favorites_provider.dart';
import 'views/main/main_screen.dart';

class IhunShop extends StatelessWidget {
  const IhunShop({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // overall theme and app layout
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'iHun Shop',
          theme: ThemeData(),
          // sets the homescreen of the app
          home: const MainScreen(),
        );
      },
    );
  }
}

final iHunShopEnter = MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (context) => MainScreenNotifier()),
    ChangeNotifierProvider(create: (context) => ProductNotifier()),
    ChangeNotifierProvider(create: (context) => FavoritesNotifier()),
    ChangeNotifierProvider(create: (context) => AuthNotifier()),
    ChangeNotifierProvider(create: (context) => CartNotifier()),
  ],
  child: const IhunShop(),
);
