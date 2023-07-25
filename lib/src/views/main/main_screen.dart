import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ihun_shop/src/config/constants.dart';
import 'package:ihun_shop/src/controllers/mainscreen_provider.dart';

import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              BottomNavigationBarItem(
                activeIcon: Icon(CupertinoIcons.house_alt_fill),
                icon: Icon(CupertinoIcons.house_alt),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(CupertinoIcons.search_circle_fill),
                icon: Icon(CupertinoIcons.search_circle),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(CupertinoIcons.square_favorites_alt_fill),
                icon: Icon(CupertinoIcons.square_favorites_alt),
                label: 'Favorite',
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(CupertinoIcons.person_alt_circle_fill),
                icon: Icon(CupertinoIcons.person_alt_circle),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
