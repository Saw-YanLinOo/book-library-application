import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:library_app/data/model/book_model.dart';
import 'package:library_app/data/model/book_model_impl.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/data/vos/shelf_vo.dart';
import 'package:library_app/viewitems/custom_show_book_view.dart';

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

  onFilterList(List<String> list) {
    _getBookByListName(list);
  }

  onFilterSortBy(SortBy viewAs) {
    _bookModel.getBookFromDatabase().listen((books) {
      debugPrint('filter by ${viewAs.name}');
      switch (viewAs) {
        case SortBy.Recently:
          {
            books?.sort((a, b) => b.openDate!.compareTo(a.openDate!));
            booklist = books;
            notifyListeners();
            break;
          }
        case SortBy.Title:
          {
            books?.sort((a, b) => a.title!.compareTo(b.title!));
            booklist = books;
            notifyListeners();
            break;
          }
        case SortBy.Author:
          {
            books?.sort((a, b) => a.author!.compareTo(b.author!));
            booklist = books;
            notifyListeners();
            break;
          }
      }
    });
  }

  onRemoveFilter() {
    _bookModel.getBookFromDatabase().listen((books) {
      booklist = books;
      notifyListeners();
    });
  }

  _getBookByListName(List<String> list) {
    _bookModel.getBookByListNameFromDatabase(list).listen((event) {
      booklist = event;
      notifyListeners();
    });
  }

  void onChanged(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
