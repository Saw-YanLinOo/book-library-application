import 'package:flutter/material.dart';
import 'package:library_app/data/model/book_model.dart';
import 'package:library_app/data/model/book_model_impl.dart';
import 'package:library_app/data/vos/book_vo.dart';

class SearchPageBloc extends ChangeNotifier {
  List<BookVO>? bookList;
  BookModel bookModel = BookModelImpl();

  SearchPageBloc();

  void searchBook(String value) {
    bookList = [];
    bookModel.searchBook(value).then((value) {
      bookList = value;
      notifyListeners();
    });
  }
}
