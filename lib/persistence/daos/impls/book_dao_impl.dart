import 'package:hive/hive.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/persistence/daos/book_dao.dart';
import 'package:library_app/persistence/hive_constants.dart';

class BookDaoImpl extends BookDao {
  BookDaoImpl._();
  static final BookDaoImpl _singleton = BookDaoImpl._();
  factory BookDaoImpl() => _singleton;

  @override
  void saveAllBook(List<BookVO> bookList) async {
    Map<String?, BookVO> _bookMap = {
      for (var book in bookList) book.title: book
    };
    await getBookBox().putAll(_bookMap);
  }

  Box<BookVO> getBookBox() {
    return Hive.box<BookVO>(BOX_NAME_BOOK_VO);
  }

  @override
  void saveSingleBook(BookVO book) async {
    await getBookBox().put(book.title, book);
  }

  @override
  List<BookVO> getAllBook() {
    return getBookBox().values.toList();
  }

  @override
  List<BookVO> getAllBookByListName(String listName) {
    return getBookBox()
        .values
        .where((element) => element.listName == listName)
        .toList();
  }

  @override
  Stream<List<BookVO>> getAllBookByListNameStream(String listName) {
    return Stream.value(getAllBookByListName(listName));
  }

  @override
  Stream<List<BookVO>> getAllBookStream() {
    return Stream.value(getAllBook());
  }

  @override
  Stream<void> getAllBooksEventStream() {
    return getBookBox().watch();
  }

  @override
  BookVO? getBookDetail(String title) {
    return getBookBox().get(title);
  }
}
