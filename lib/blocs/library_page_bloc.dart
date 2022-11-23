import 'package:flutter/material.dart';

class LibraryPageBloc extends ChangeNotifier {
  int currentIndex = 0;

  void onChanged(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
