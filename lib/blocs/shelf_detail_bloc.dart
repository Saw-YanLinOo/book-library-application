import 'package:flutter/material.dart';
import 'package:library_app/data/model/book_model.dart';
import 'package:library_app/data/model/book_model_impl.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/data/vos/shelf_vo.dart';

class SehlfDetailBloc extends ChangeNotifier {
  ShelfVO? shelf;
  List<BookVO>? booklist;
  bool edit = false;
  var isDispose = false;

  BookModel bookModel = BookModelImpl();

  SehlfDetailBloc(ShelfVO shelfVO) {
    bookModel.getShelfFromDatabase(shelfVO.index ?? '').listen((event) {
      shelf = event;
      booklist = event?.bookList;
      notifysafely();
    });
  }

  onedit(bool value) {
    debugPrint('edit $value');
    edit = value;
    notifyListeners();
  }

  renameShelf(String name, String index) {
    debugPrint('rename shelf $name');
    bookModel.renameShelf(name, index);
  }

  onDeleteShelf(String index) {
    bookModel.deleteShelf(index);
  }

  void notifysafely() {
    if (isDispose == false) {
      notifyListeners();
    }
  }
}
