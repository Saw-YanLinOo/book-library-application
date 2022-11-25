import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:library_app/data/model/book_model.dart';
import 'package:library_app/data/model/book_model_impl.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/data/vos/list_vo.dart';

class HomePageBloc extends ChangeNotifier {
  List<ListVO>? overviewlist;
  List<BookVO>? previewbooklist;

  final BookModel _bookModel = BookModelImpl();
  String date = DateFormat('yyy-MM-dd').format(DateTime.now());

  HomePageBloc() {
    _bookModel.getOverViewJsonFromDatabase(date).listen((event) {
      debugPrint("get from database :::: $event");
      overviewlist = event?.lists;
      notifyListeners();
    });

    _bookModel.getBookFromDatabase().listen((books) {
      previewbooklist = books;
      notifyListeners();
    });
  }
  int currentIndex = 0;

  void onChanged(int index) {
    currentIndex = index;
    notifyListeners();
  }

  // saveBook(BookVO book) {
  //   _bookModel.saveBook(book);
  // }
}
