import 'package:flutter/cupertino.dart';
import 'package:library_app/data/model/book_model.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/data/vos/over_view_vo.dart';
import 'package:library_app/network/dataagents/book_data_agent.dart';
import 'package:library_app/network/dataagents/retrofit_data_agent.dart';
import 'package:library_app/persistence/daos/book_dao.dart';
import 'package:library_app/persistence/daos/impls/book_dao_impl.dart';

class BookModelImpl implements BookModel {
  BookDataAgent mDataAgent = RetrofitBookDataAgent();

  BookModelImpl._();
  static final BookModelImpl _singleton = BookModelImpl._();
  factory BookModelImpl() => _singleton;

  BookDao mBookDao = BookDaoImpl();

  @override
  void getOverViewJson() {
    mDataAgent.getOverViewJson().then((result) {
      List<BookVO> bookList = [];

      result?.forEach((overview) {
        overview.lists?.forEach((list) {
          list.books?.forEach((book) {
            book.listName = list.listName;
            bookList.add(book);
          });
        });
      });

      mBookDao.saveAllBook(bookList);
    });
  }

  @override
  Future<List<OverViewVO>?> getOverViewJsonFromDatabase() {
    return mDataAgent.getOverViewJson();
  }
}
