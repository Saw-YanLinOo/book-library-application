import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/data/vos/over_view_vo.dart';
import 'package:library_app/data/vos/shelf_vo.dart';

abstract class BookModel {
  void saveBook(BookVO book);
  void saveShelf(ShelfVO shelf);
  void getOverViewJson(String date);
  Stream<OverViewVO?> getOverViewJsonFromDatabase(String date);
  Stream<List<BookVO>?> getBookFromDatabase();
  Stream<List<String>?> getListNameFromDatabase();
  Stream<List<BookVO>?> getBookByListNameFromDatabase(List<String> listName);
  Stream<List<ShelfVO>?> getAllShelfFromDatabase();
}
