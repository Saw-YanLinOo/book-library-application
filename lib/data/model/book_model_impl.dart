import 'package:flutter/cupertino.dart';
import 'package:library_app/data/model/book_model.dart';
import 'package:library_app/data/vos/over_view_vo.dart';
import 'package:library_app/network/dataagents/book_data_agent.dart';
import 'package:library_app/network/dataagents/retrofit_data_agent.dart';

class BookModelImpl implements BookModel {
  BookDataAgent mDataAgent = RetrofitBookDataAgent();

  BookModelImpl._();
  static final BookModelImpl _singleton = BookModelImpl._();
  factory BookModelImpl() => _singleton;

  @override
  void getOverViewJson() {
    mDataAgent.getOverViewJson().then((value) {
      debugPrint('value :: ${value?.toString()}');
    });
  }

  @override
  Future<List<OverViewVO>?> getOverViewJsonFromDatabase() {
    return mDataAgent.getOverViewJson();
  }
}
