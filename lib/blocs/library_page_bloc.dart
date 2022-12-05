import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:library_app/data/model/book_model.dart';
import 'package:library_app/data/model/book_model_impl.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/data/vos/shelf_vo.dart';
import 'package:library_app/widgets/custom_show_book_view.dart';

class LibraryPageBloc extends ChangeNotifier {
  int currentIndex = 0;

  List<BookVO>? booklist;
  List<String>? filterlist = [];
  List<ShelfVO>? shelflist;

  BookModel _bookModel = BookModelImpl();

  LibraryPageBloc() {
    _bookModel.getBookFromDatabase().listen((books) {
      booklist = books;
      filterlist = books?.map((e) => e.listName ?? '').toSet().toList() ?? [];
      notifyListeners();
    });

    _bookModel.getAllShelfFromDatabase().listen((event) {
      debugPrint("get your shelf page");
      shelflist = event;
      notifyListeners();
    });
  }

  getShref() {
    _bookModel.getAllShelfFromDatabase().listen((event) {
      debugPrint("get your shelf page");
      shelflist = event;
      notifyListeners();
    });
  }

  void onChanged(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
