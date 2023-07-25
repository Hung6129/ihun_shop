import 'package:flutter/material.dart';

import 'package:ihun_shop/controllers/mainscreen_provider.dart';
import 'package:ihun_shop/views/favorite/favorite_page.dart';
import 'package:ihun_shop/views/home/home_page.dart';
import 'package:ihun_shop/views/profile/profile_page.dart';

import 'package:provider/provider.dart';

import '../search/search_page.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> pageList = [
      const HomePage(),
      const SearchPage(),
      const FavoritePage(),
      const ProfilePage()
    ];
    return Consumer<MainScreenNotifier>(
      builder: (context, mainScreenNotifier, child) {
        return Scaffold(
          backgroundColor: const Color(0xFFE2E2E2),
          body: pageList[mainScreenNotifier.pageIndex],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.black,
            backgroundColor: Colors.white,
            unselectedItemColor: Colors.black.withOpacity(0.5),
            showUnselectedLabels: false,
            showSelectedLabels: false,
            type: BottomNavigationBarType.fixed,
            currentIndex: mainScreenNotifier.pageIndex,
            onTap: (index) {
              mainScreenNotifier.pageIndex = index;
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: 'Search'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Favorite'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile'),
            ],
          ),
        );
      },
    );
  }
}
