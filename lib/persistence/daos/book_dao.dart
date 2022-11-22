import 'package:library_app/data/vos/book_vo.dart';

abstract class BookDao {
  void saveAllBook(List<BookVO> bookList);
  void saveSingleBook(BookVO book);
  List<BookVO> getAllBook();
  List<BookVO> getAllBookByListName(String listName);
  BookVO? getBookDetail(String title);
  Stream<void> getAllBooksEventStream();
  Stream<List<BookVO>> getAllBookStream();
  Stream<List<BookVO>> getAllBookByListNameStream(String listName);
}
