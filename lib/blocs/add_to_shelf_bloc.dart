import 'package:flutter/material.dart';
import 'package:library_app/data/model/book_model.dart';
import 'package:library_app/data/model/book_model_impl.dart';
import 'package:library_app/data/vos/shelf_vo.dart';

class AddToShelfBloc extends ChangeNotifier {
  List<ShelfVO>? shelfList;
  BookModel _bookModel = BookModelImpl();

  AddToShelfBloc() {
    debugPrint("init add to shelf bloc");
    _bookModel.getAllShelfFromDatabase().listen((event) {
      shelfList = event;
      notifyListeners();
    });
  }

  addShelf(ShelfVO shelf) {
    _bookModel.saveShelf(shelf);
  }
}
