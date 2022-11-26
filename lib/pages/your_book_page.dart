import 'package:flutter/material.dart';
import 'package:library_app/blocs/home_page_bloc.dart';
import 'package:library_app/blocs/library_page_bloc.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/pages/add_to_shelf_page.dart';
import 'package:library_app/pages/book_detail_page.dart';
import 'package:library_app/pages/bottomsheet_page/book_setting_shelf_view.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_show_book_view.dart';

class YourBookPage extends StatelessWidget {
  const YourBookPage({Key? key}) : super(key: key);

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
              booklist: books,
              filterlist: lists,
              onTapBook: (book) {},
              onTapSeeMore: (book) {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return ChangeNotifierProvider.value(
                          value: HomePageBloc(),
                          builder: (context, child) {
                            return BookSettingSheetView(
                              book: book,
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
                                context
                                    .read<HomePageBloc>()
                                    .deleteBook(book?.title ?? '');
                                Navigator.pop(context);
                              },
                            );
                          });
                    });
              },
              onRemoveFilter: () {
                LibraryPageBloc bloc = Provider.of(context, listen: false);
                bloc.onRemoveFilter();
              },
              onFilterCategory: (value) {
                LibraryPageBloc bloc = Provider.of(context, listen: false);
                bloc.onFilterList(value ?? []);
              },
              onSortByFilter: (SortBy sortBy) {
                LibraryPageBloc bloc = Provider.of(context, listen: false);
                bloc.onFilterSortBy(sortBy);
              },
            );
          },
        );
      },
    );
  }
}
