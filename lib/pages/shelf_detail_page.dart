import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:library_app/blocs/shelf_bloc.dart';
import 'package:library_app/blocs/shelf_detail_bloc.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/data/vos/shelf_vo.dart';
import 'package:library_app/pages/bottomsheet_page/update_shelf_view.dart';
import 'package:library_app/pages/home.dart';
import 'package:library_app/pages/home_page.dart';
import 'package:library_app/resourses/dimens.dart';
import 'package:library_app/widgets/custom_show_book_view.dart';
import 'package:provider/provider.dart';

class ShelfDetailPage extends StatefulWidget {
  const ShelfDetailPage({
    Key? key,
    this.shelf,
  }) : super(key: key);

  final ShelfVO? shelf;

  @override
  State<ShelfDetailPage> createState() => _ShelfDetailPageState();
}

class _ShelfDetailPageState extends State<ShelfDetailPage> {
  void showNavigation(
    BuildContext context,
    Function onTapEdit,
    Function onDelected,
  ) async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ChangeNotifierProvider.value(
          value: SehlfDetailBloc(widget.shelf ?? ShelfVO()),
          builder: (context, child) {
            return UpdateShelfView(
              shelfName: widget.shelf?.shelfName,
              onEdit: () {
                onTapEdit();
              },
              onDelected: () {
                onDelected();
                // context
                //     .read<SehlfDetailBloc>()
                //     .onDeleteShelf(widget.shelf?.index ?? '');
                // Timer(const Duration(seconds: 1), () {
                //   Navigator.of(context)
                //     ..pop()
                //     ..pop();
                // });
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('shelf :: ${widget.shelf?.index}');
    var filterList = widget.shelf?.bookList
        ?.map((element) => element.listName ?? '')
        .toSet()
        .toList();

    return ChangeNotifierProvider<SehlfDetailBloc>(
      create: (context) => SehlfDetailBloc(widget.shelf ?? ShelfVO()),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          actions: [
            InkWell(
              onTap: () async {
                showNavigation(context, () {
                  debugPrint('edit shelf name');
                  context.read<SehlfDetailBloc>().onedit(true);
                  Navigator.pop(context, true);
                }, () {
                  debugPrint('on delete shelf');
                  context
                      .read<SehlfDetailBloc>()
                      .onDeleteShelf(widget.shelf?.index ?? '');
                  Timer(const Duration(seconds: 1), () {
                    Navigator.of(context)
                      ..pop()
                      ..pop();
                  });
                });
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM),
                child: const Icon(
                  FontAwesomeIcons.ellipsis,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: MARGIN_XL_LARGE,
            ),
            Selector<SehlfDetailBloc, ShelfVO?>(
                selector: (context, bloc) => bloc.shelf,
                builder: (context, shelf, child) {
                  var shelfVO = shelf;
                  return Selector<SehlfDetailBloc, bool>(
                      selector: (context, bloc) => bloc.edit,
                      builder: (context, edit, child) {
                        return ShelfHeaderSection(
                          edit: edit,
                          shelfVO: shelfVO,
                          onEditSummit: (value) {
                            var bloc = context.read<SehlfDetailBloc>();

                            bloc.renameShelf(value ?? '', shelfVO?.index ?? '');
                            bloc.onedit(false);
                          },
                        );
                      });
                }),
            const Divider(),
            Expanded(
              child: Selector<SehlfDetailBloc, List<BookVO>?>(
                selector: (context, bloc) => bloc.booklist,
                builder: (context, booklist, child) {
                  debugPrint('shelf book list ::: ${booklist}');
                  return SizedBox(
                    child: booklist == null || (booklist.isEmpty)
                        ? const Center(
                            child: Text('no book'),
                          )
                        : CustomShowBookView(
                            booklist: booklist,
                            filterlist: filterList,
                            onTapBook: (book) {},
                            onTapSeeMore: (book) {},
                            onFilterCategory: (list) {
                              context
                                  .read<SehlfDetailBloc>()
                                  .onFilerListName(list ?? []);
                            },
                            onRemoveFilter: () {
                              context.read<SehlfDetailBloc>().onRemoveFilter();
                            },
                            onSortByFilter: (sortBy) {
                              context
                                  .read<SehlfDetailBloc>()
                                  .onFilterSortBy(sortBy);
                            },
                          ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShelfHeaderSection extends StatelessWidget {
  const ShelfHeaderSection({
    Key? key,
    required this.edit,
    required this.shelfVO,
    required this.onEditSummit,
  }) : super(key: key);

  final bool edit;
  final ShelfVO? shelfVO;
  final Function(String?) onEditSummit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: !edit,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: MARGIN_MEDIUM_3,
            ),
            child: Text(
              '${shelfVO?.shelfName}',
              style: const TextStyle(
                fontSize: TEXT_HEADING_1X,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Visibility(
          visible: edit,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: MARGIN_MEDIUM_3,
            ),
            child: TextFormField(
              initialValue: '${shelfVO?.shelfName}',
              onFieldSubmitted: (value) {
                onEditSummit(value);
              },
              onSaved: (value) {
                onEditSummit(value);
              },
            ),
          ),
        ),
        const SizedBox(
          height: MARGIN_SMALL,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: MARGIN_MEDIUM_3,
          ),
          child: Text(
            '${shelfVO?.bookList?.length ?? 0} book',
            style: const TextStyle(
              fontSize: TEXT_SMALL,
            ),
          ),
        ),
      ],
    );
  }
}
