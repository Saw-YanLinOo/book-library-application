import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/data/vos/shelf_vo.dart';
import 'package:library_app/persistence/daos/shelf_dao.dart';
import 'package:library_app/persistence/hive_constants.dart';
import 'package:uuid/uuid.dart';

class ShelfDaoImpl extends ShelfDao {
  @override
  List<ShelfVO>? getAllShelf() {
    return getSelfBox().values.toList();
  }

  @override
  Stream<List<ShelfVO>?> getAllShelfStream() {
    return Stream.value(getAllShelf());
  }

  @override
  void saveShelf(ShelfVO shelfVO) async {
    debugPrint('save shelf index :: ${shelfVO.index}');
    await getSelfBox().put(shelfVO.index, shelfVO);
  }

  @override
  Stream<void> getAllShelfEventStream() {
    return getSelfBox().watch();
  }

  Box<ShelfVO> getSelfBox() {
    return Hive.box<ShelfVO>(BOX_NAME_SHELF_VO);
  }

  @override
  ShelfVO? getShelf(String index) {
    return getSelfBox().get(index);
  }

  @override
  Stream<ShelfVO?> getShelfStream(String index) {
    return Stream.value(getShelf(index));
  }

  @override
  void removeShelf(String index) {
    getSelfBox().delete(index);
  }

  @override
  void renameShelf(String name, String index) {
    var shelf = getShelf(index);
    shelf?.shelfName = name;
    saveShelf(shelf ?? ShelfVO());
  }

  @override
  void addBooToShelf(String index, BookVO bookVO) {
    var shelf = getShelf(index);
    shelf?.bookList ??= [];
    shelf?.bookTiteList ??= [];
    shelf?.bookList?.add(bookVO);
    shelf?.bookTiteList?.add(bookVO.title ?? '');

    debugPrint('add book to shelf($index) bookList :: ${shelf?.bookList}');
    saveShelf(shelf ?? ShelfVO());
  }

  @override
  void removeBooToShelf(String index, BookVO bookVO) {
    var shelf = getShelf(index);

    // shelf?.bookList?.remove(bookVO);
    // shelf?.bookTiteList?.remove(bookVO.title ?? '');
    // debugPrint('remove book to shelf($index) bookList :: ${shelf?.bookList}');

    // saveShelf(shelf ?? ShelfVO());
  }
}
