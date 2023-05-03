import 'package:flutter/material.dart';

import 'pages.dart';

class AppState extends ChangeNotifier {
  int _selectedIndex = 1;

  int get selectedIndex {
    return _selectedIndex;
  }

  set selectedIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }

  AppPage get currentPage {
    return pages[_selectedIndex];
  }
}
