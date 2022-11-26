import 'package:library_app/data/vos/book_vo.dart';

abstract class BookDao {
  void saveAllBook(List<BookVO> bookList);
  void saveSingleBook(BookVO book);
  void deleteBook(String title);
  List<BookVO> getAllBook();
  List<String>? getListName();
  List<BookVO> getAllBookByListName(List<String> listName);
  BookVO? getBookDetail(String title);
  Stream<void> getAllBooksEventStream();
  Stream<List<BookVO>> getAllBookStream();
  Stream<List<String>?> getListNameStream();
  Stream<List<BookVO>> getAllBookByListNameStream(List<String> listName);
}
