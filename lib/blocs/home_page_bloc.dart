import 'package:flutter/material.dart';
import 'package:library_app/data/model/book_model.dart';
import 'package:library_app/data/model/book_model_impl.dart';
import 'package:library_app/data/vos/list_vo.dart';

class HomePageBloc extends ChangeNotifier{

  List<ListVO>? overviewlist;

  BookModel _bookModel = BookModelImpl();
  String date = DateTime.now().toIso8601String();

  HomePageBloc(){

    _bookModel.getOverViewJsonFromDatabase(date).listen((event) {
      overviewlist = event?.lists;
      notifyListeners();
    });
  }
}