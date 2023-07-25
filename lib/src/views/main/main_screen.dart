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
