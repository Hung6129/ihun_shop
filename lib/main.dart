import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ihun_shop/src/controllers/sign_in_provider.dart';
import 'package:provider/provider.dart';
import 'src/controllers/favorites_provider.dart';
import 'src/controllers/mainscreen_provider.dart';
import 'src/controllers/product_provider.dart';
import 'src/global.dart';
import 'src/views/main/main_screen.dart';

// entrypoint of the app
void main() async {
  await Global.init();
  //method that initializes the app and run top level wigets
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MainScreenNotifier()),
        ChangeNotifierProvider(create: (context) => ProductNotifier()),
        ChangeNotifierProvider(create: (context) => FavoritesNotifier()),
        ChangeNotifierProvider(create: (context) => SignInNotifier()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
