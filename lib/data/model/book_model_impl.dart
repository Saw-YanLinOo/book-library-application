import 'package:flutter/cupertino.dart';
import 'package:library_app/data/model/book_model.dart';
import 'package:library_app/data/vos/over_view_vo.dart';
import 'package:library_app/network/dataagents/book_data_agent.dart';
import 'package:library_app/network/dataagents/retrofit_data_agent.dart';
import 'package:library_app/persistence/daos/book_dao.dart';
import 'package:library_app/persistence/daos/impls/book_dao_impl.dart';
import 'package:library_app/persistence/daos/impls/overview_dao_impl.dart';
import 'package:library_app/persistence/daos/overview_dao.dart';
import 'package:stream_transform/stream_transform.dart';

class BookModelImpl implements BookModel {
  BookDataAgent mDataAgent = RetrofitBookDataAgent();

  BookModelImpl._();
  static final BookModelImpl _singleton = BookModelImpl._();
  factory BookModelImpl() => _singleton;

  OverViewDao mOverViewDao = OverViewDaoImpl();
  BookDao mBookDao = BookDaoImpl();

  @override
  void getOverViewJson(String date) {
    debugPrint('fetch overview');
    mDataAgent.getOverViewJson(date).then((result) {
      mOverViewDao.saveOverView(date, result ?? OverViewVO());
    });
  }

  @override
  Stream<OverViewVO?> getOverViewJsonFromDatabase(String date) {
    getOverViewJson(date);
    return mOverViewDao
        .getOverViewEventStream()
        .startWith(mOverViewDao.getOverViewFromDatabase(date))
        .map((event) => mOverViewDao.getOverView(date));
  }
}
