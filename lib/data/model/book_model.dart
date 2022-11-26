import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/data/vos/over_view_vo.dart';
import 'package:library_app/data/vos/shelf_vo.dart';

abstract class BookModel {
  void getOverViewJson(String date);
  void saveBook(BookVO book);
  void deleteBook(String title);
  void saveShelf(ShelfVO shelf);
  void deleteShelf(String index);
  void renameShelf(String name, String index);
  void addBookToShelf(String index,BookVO bookVO);
  void removeBookToShelf(String index,BookVO bookVO);
  Stream<OverViewVO?> getOverViewJsonFromDatabase(String date);
  Stream<List<BookVO>?> getBookFromDatabase();
  Stream<List<String>?> getListNameFromDatabase();
  Stream<List<BookVO>?> getBookByListNameFromDatabase(List<String> listName);
  Stream<List<ShelfVO>?> getAllShelfFromDatabase();
  Stream<ShelfVO?> getShelfFromDatabase(String index);
}
