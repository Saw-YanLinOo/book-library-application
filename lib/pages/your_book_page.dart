import 'package:flutter/material.dart';
import 'package:library_app/blocs/library_page_bloc.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:provider/provider.dart';

import '../viewitems/custom_show_book_view.dart';

class YourBookPage extends StatelessWidget {
  const YourBookPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<LibraryPageBloc, List<String>?>(
      selector: (context, bloc) => bloc.filterlist,
      builder: (context, lists, child) {
        debugPrint('list ${lists?.length}');

        return Selector<LibraryPageBloc, List<BookVO>?>(
          selector: (context, bloc) => bloc.booklist,
          builder: (context, books, child) {
            if (books == null || books.isEmpty) {
              return const CircularProgressIndicator();
            }

            return CustomShowBookView(
              booklist: books,
              filterlist: lists,
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
