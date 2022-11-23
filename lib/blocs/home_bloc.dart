import 'package:flutter/material.dart';
import 'package:library_app/pages/home_page.dart';
import 'package:library_app/pages/library_page.dart';

class HomeBloc extends ChangeNotifier {
  int currentIndex = 0;
  static const pages = [
    HomePage(),
    LibraryPage(),
  ];

  void onChanged(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
