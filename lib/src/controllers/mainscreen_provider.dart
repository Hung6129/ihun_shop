import 'package:flutter/material.dart';

/// This class is a ChangeNotifier class that notifies its listeners when
/// the value of any of its properties changes.
/// MainScreenNotifier class is used to manage the state of the app.
/// It notifies its listeners when the user changes the page.

class MainScreenNotifier extends ChangeNotifier {
  int _pageIndex = 0;

  int get pageIndex => _pageIndex;

  set pageIndex(int newIndex) {
    _pageIndex = newIndex;
    notifyListeners();
  }
}
