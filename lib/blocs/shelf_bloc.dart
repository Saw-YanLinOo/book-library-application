import 'package:flutter/material.dart';
import 'package:library_app/data/model/book_model.dart';
import 'package:library_app/data/model/book_model_impl.dart';
import 'package:library_app/data/vos/shelf_vo.dart';
import 'package:uuid/uuid.dart';

class ShelfBloc extends ChangeNotifier {
  List<ShelfVO>? shelflist;

  BookModel _bookModel = BookModelImpl();

  ShelfBloc() {
    _bookModel.getAllShelfFromDatabase().listen((event) {
      debugPrint("get shelf page");
      shelflist = event;
      notifyListeners();
    });
  }

  addShelf(ShelfVO shelf) {
    shelf.index = Uuid().v4();
    _bookModel.saveShelf(shelf);
  }
}
