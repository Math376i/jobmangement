import 'package:flutter/material.dart';

import 'pages.dart';

class AppState extends ChangeNotifier {
  int _selectedIndex = 1;

  var primary = Color(0xFFD7FDEC);
  var secondary = Color(0xFF607D8B);
  var accent = Color(0xFFA9FBD7);

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
