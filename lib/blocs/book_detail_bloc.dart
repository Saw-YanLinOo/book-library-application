import 'package:flutter/material.dart';
import 'package:library_app/data/model/book_model.dart';
import 'package:library_app/data/model/book_model_impl.dart';
import 'package:library_app/data/vos/book_vo.dart';

class BookDetailBloc extends ChangeNotifier {
  final BookModel _bookModel = BookModelImpl();

  BookDetailBloc(BookVO book) {
    debugPrint("save book");
    _bookModel.saveBook(book);
  }
}
