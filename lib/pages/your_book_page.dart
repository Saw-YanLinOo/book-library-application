import 'package:flutter/material.dart';
import 'package:library_app/blocs/home_page_bloc.dart';
import 'package:library_app/blocs/library_page_bloc.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/pages/add_to_shelf_page.dart';
import 'package:library_app/pages/book_detail_page.dart';
import 'package:library_app/pages/bottomsheet_page/book_setting_shelf_view.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_show_book_view.dart';

class YourBookPage extends StatefulWidget {
  const YourBookPage({Key? key}) : super(key: key);

  @override
  State<YourBookPage> createState() => _YourBookPageState();
}

class _YourBookPageState extends State<YourBookPage> {
  showButtonSheet(BuildContext context, BookVO? book) {
    showModalBottomSheet(
        useRootNavigator: true,
        isScrollControlled: true,
        context: context,
        builder: (_) {
          return ChangeNotifierProvider.value(
            value: LibraryPageBloc(),
            child: BookSettingSheetView(
              book: book,
              onTapClose: () {
                Navigator.of(context).pop();
              },
              onTapAboutThisBook: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookDetailPage(
                      listName: book?.listName,
                      mBook: book,
                    ),
                  ),
                );
              },
              onTapAddToShelf: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddToShelfPage(
                      book: book,
                    ),
                  ),
                );
              },
              onTapDelete: () {
                var bloc = Provider.of<LibraryPageBloc>(context, listen: false);

                bloc.deleteBook(book?.title ?? '');
                Navigator.pop(context);
              },
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Selector<LibraryPageBloc, List<String>?>(
      selector: (context, bloc) => bloc.filterlist,
      builder: (context, lists, child) {
        debugPrint('list ${lists?.length}');

        return Selector<LibraryPageBloc, List<BookVO>?>(
          shouldRebuild: (previous, next) => true,
          selector: (context, bloc) => bloc.booklist,
          builder: (context, books, child) {
            if (books == null || books.isEmpty) {
              return const Center(
                child: Text('no book'),
              );
            }

            return CustomShowBookView(
              key: UniqueKey(),
              booklist: books,
              filterlist: lists,
              onTapBook: (book) {},
              onTapSeeMore: (book) {
                showModalBottomSheet(
                    useRootNavigator: true,
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return ChangeNotifierProvider.value(
                        value: LibraryPageBloc(),
                        child: BookSettingSheetView(
                          book: book,
                          onTapClose: () {
                            Navigator.of(context).pop();
                          },
                          onTapAboutThisBook: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookDetailPage(
                                  listName: book?.listName,
                                  mBook: book,
                                ),
                              ),
                            );
                          },
                          onTapAddToShelf: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddToShelfPage(
                                  book: book,
                                ),
                              ),
                            );
                          },
                          onTapDelete: () {
                            var bloc = Provider.of<LibraryPageBloc>(context,
                                listen: false);

                            bloc.deleteBook(book?.title ?? '');
                            Navigator.pop(context);
                          },
                        ),
                      );
                    });
              },
            );
          },
        );
      },
    );
  }
}
