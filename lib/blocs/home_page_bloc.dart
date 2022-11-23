import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:library_app/data/model/book_model.dart';
import 'package:library_app/data/model/book_model_impl.dart';
import 'package:library_app/data/vos/list_vo.dart';

class HomePageBloc extends ChangeNotifier {
  List<ListVO>? overviewlist;

  final BookModel _bookModel = BookModelImpl();
  String date = DateFormat('yyy-MM-dd').format(DateTime.now());

  HomePageBloc() {
    _bookModel.getOverViewJsonFromDatabase(date).listen((event) {
      overviewlist = event?.lists;
      notifyListeners();
    });
  }
}
