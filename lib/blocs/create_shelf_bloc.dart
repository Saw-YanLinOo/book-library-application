import 'package:flutter/material.dart';
import 'package:library_app/data/model/book_model.dart';
import 'package:library_app/data/model/book_model_impl.dart';
import 'package:library_app/data/vos/shelf_vo.dart';
import 'package:uuid/uuid.dart';

class CreateShelfBloc extends ChangeNotifier {
  List<ShelfVO>? shelflist;
  bool isDisposed = false;

  final BookModel _bookModel = BookModelImpl();

  CreateShelfBloc();

  addShelf(ShelfVO shelf) {
    shelf.index = Uuid().v4();
    _bookModel.saveShelf(shelf);
  }

  void notifysafely() {
    if (isDisposed == false) {
      notifyListeners();
    }
  }
}
