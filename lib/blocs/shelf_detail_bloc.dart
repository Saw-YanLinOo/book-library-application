import 'package:flutter/material.dart';
import 'package:library_app/data/model/book_model.dart';
import 'package:library_app/data/model/book_model_impl.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/data/vos/shelf_vo.dart';
import 'package:library_app/widgets/custom_show_book_view.dart';

class SehlfDetailBloc extends ChangeNotifier {
  ShelfVO? shelf;
  List<BookVO>? booklist;
  bool edit = false;

  BookModel bookModel = BookModelImpl();

  SehlfDetailBloc(ShelfVO shelfVO) {
    bookModel.getShelfFromDatabase(shelfVO.index ?? '').listen((event) {
      shelf = event;
      booklist = event?.bookList;
      notifyListeners();
    });
  }

  onedit(bool value) {
    debugPrint('edit $value');
    edit = value;
    notifyListeners();
  }

  renameShelf(String name, String index) {
    debugPrint('rename shelf $name');
    bookModel.renameShelf(name, index);
  }

  onDeleteShelf(String index) {
    bookModel.deleteShelf(index);
  }

  onFilerListName(List<String> listName) {
    List<BookVO> books = List.from(shelf?.bookList ?? []);

    booklist =
        books.where((element) => listName.contains(element.listName)).toList();
    notifyListeners();
  }

  onRemoveFilter() {
    booklist = List.from(shelf?.bookList ?? []);
    notifyListeners();
  }

  onFilterSortBy(SortBy sortBy) {
    List<BookVO> books = List.from(shelf?.bookList ?? []);

    switch (sortBy) {
      case SortBy.Recently:
        {
          books.sort((a, b) => b.openDate!.compareTo(a.openDate!));
          booklist = books;
          notifyListeners();
          break;
        }
      case SortBy.Title:
        {
          books.sort((a, b) => a.title!.compareTo(b.title!));
          booklist = books;
          notifyListeners();
          break;
        }
      case SortBy.Author:
        {
          books.sort((a, b) => a.author!.compareTo(b.author!));
          booklist = books;
          notifyListeners();
          break;
        }
    }
  }
}
