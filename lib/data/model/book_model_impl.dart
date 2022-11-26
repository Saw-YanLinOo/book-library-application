import 'package:flutter/cupertino.dart';
import 'package:library_app/data/model/book_model.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/data/vos/over_view_vo.dart';
import 'package:library_app/data/vos/shelf_vo.dart';
import 'package:library_app/network/dataagents/book_data_agent.dart';
import 'package:library_app/network/dataagents/retrofit_data_agent.dart';
import 'package:library_app/persistence/daos/book_dao.dart';
import 'package:library_app/persistence/daos/impls/book_dao_impl.dart';
import 'package:library_app/persistence/daos/impls/overview_dao_impl.dart';
import 'package:library_app/persistence/daos/impls/shelf_dao_impl.dart';
import 'package:library_app/persistence/daos/overview_dao.dart';
import 'package:library_app/persistence/daos/shelf_dao.dart';
import 'package:stream_transform/stream_transform.dart';

class BookModelImpl implements BookModel {
  BookDataAgent mDataAgent = RetrofitBookDataAgent();

  BookModelImpl._();
  static final BookModelImpl _singleton = BookModelImpl._();
  factory BookModelImpl() => _singleton;

  OverViewDao mOverViewDao = OverViewDaoImpl();
  BookDao mBookDao = BookDaoImpl();
  ShelfDao mShelfDao = ShelfDaoImpl();

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

  @override
  Stream<List<BookVO>?> getBookFromDatabase() {
    debugPrint("get book from db");
    return mBookDao
        .getAllBooksEventStream()
        .startWith(mBookDao.getAllBookStream())
        .map((event) => mBookDao.getAllBook());
  }

  @override
  void saveBook(BookVO book) {
    debugPrint("Save Book");
    mBookDao.saveSingleBook(book);
  }

  @override
  Stream<List<BookVO>?> getBookByListNameFromDatabase(List<String> listName) {
    debugPrint('book by list name $listName');
    return mBookDao
        .getAllBooksEventStream()
        .startWith(mBookDao.getAllBookByListNameStream(listName))
        .map((event) => mBookDao.getAllBookByListName(listName));
  }

  @override
  Stream<List<String>?> getListNameFromDatabase() {
    return mBookDao
        .getAllBooksEventStream()
        .startWith(mBookDao.getListNameStream())
        .map((event) => mBookDao.getListName());
  }

  @override
  Stream<List<ShelfVO>?> getAllShelfFromDatabase() {
    return mShelfDao
        .getAllShelfEventStream()
        .startWith(mShelfDao.getAllShelfStream())
        .map((event) => mShelfDao.getAllShelf());
  }

  @override
  void saveShelf(ShelfVO shelf) {
    debugPrint('save shelf');
    mShelfDao.saveShelf(shelf);
  }

  @override
  Stream<ShelfVO?> getShelfFromDatabase(String index) {
    return mShelfDao
        .getAllShelfStream()
        .map((event) => mShelfDao.getShelf(index));
  }

  @override
  void deleteShelf(String index) {
    mShelfDao.removeShelf(index);
  }

  @override
  void renameShelf(String name, String index) {
    mShelfDao.renameShelf(name, index);
  }

  @override
  void deleteBook(String title) {
    mBookDao.deleteBook(title);
  }

  @override
  void addBookToShelf(String index, BookVO bookVO) {
    mShelfDao.addBooToShelf(index, bookVO);
  }

  @override
  void removeBookToShelf(String index, BookVO bookVO) {
    mShelfDao.removeBooToShelf(index, bookVO);
  }
}
