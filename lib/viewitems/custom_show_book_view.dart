import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/resourses/dimens.dart';
import 'package:library_app/viewitems/book_view_item.dart';
import 'package:library_app/viewitems/large_book_view_item.dart';

enum ViewAs {
  List,
  LargeGrid,
  SmallGrid,
}

enum SortBy {
  Recently,
  Title,
  Author,
}

class CustomShowBookView extends StatefulWidget {
  const CustomShowBookView({
    Key? key,
    this.booklist,
    this.filterlist,
    required this.onFilterCategory,
    required this.onRemoveFilter,
    required this.onSortByFilter,
  }) : super(key: key);

  final List<BookVO>? booklist;
  final List<String>? filterlist;
  final Function(List<String>?) onFilterCategory;
  final Function(SortBy sortBy) onSortByFilter;
  final Function onRemoveFilter;

  @override
  State<CustomShowBookView> createState() => _CustomShowBookViewState();
}

class _CustomShowBookViewState extends State<CustomShowBookView>
    with SingleTickerProviderStateMixin {
  List<String>? selectedList = [];
  List<String>? unSelectedList = [];
  ViewAs viewAs = ViewAs.List;
  int groupValue = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // unSelectedList = widget.filterlist;
    unSelectedList = List.from(widget.filterlist ?? []);
  }

  onTapCategory(String? value) {
    selectedList ??= [];
    selectedList?.add(value ?? '');
    unSelectedList?.remove(value);

    widget.onFilterCategory(selectedList);
  }

  onRemoveCatgory() {
    selectedList = null;
    unSelectedList = List.from(widget.filterlist ?? []);
    widget.onRemoveFilter();
  }

  _onTapViewas(ViewAs mViewAs, int index) {
    viewAs = mViewAs;
    groupValue = index;
    // widget.onViewAsFilter(mViewAs);
    setState(() {});
  }

  _onChangedSortBy(SortBy sortBy, int index) {
    groupValue = index;
    widget.onSortByFilter(sortBy);
    //ssetState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          // padding: const EdgeInsets.symmetric(
          //   horizontal: MARGIN_CARD_MEDIUM_2,
          // ),
          child: SizedBox(
            height: MARGIN_XL_LARGE,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
              physics: const BouncingScrollPhysics(),
              children: [
                Visibility(
                  visible: selectedList?.isNotEmpty ?? false,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 0.2),
                      borderRadius: BorderRadius.circular(
                        MARGIN_MEDIUM_2,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(MARGIN_SMALL),
                      child: InkWell(
                        onTap: () {
                          onRemoveCatgory();
                        },
                        child: Icon(
                          Icons.clear,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MARGIN_MEDIUM,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: selectedList?.length ?? 0,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var book = selectedList?[index];

                    return Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
                      child: Chip(label: Text('${book}')),
                    );
                  },
                ),
                Container(
                  height: MARGIN_XL_LARGE,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 0.2),
                    borderRadius: BorderRadius.circular(
                      MARGIN_CARD_MEDIUM_3,
                    ),
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: unSelectedList?.length ?? 0,
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var book = unSelectedList?[index];

                      return InkWell(
                        onTap: () {
                          onTapCategory(book);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: MARGIN_CARD_MEDIUM_2,
                            vertical: MARGIN_MEDIUM,
                          ),
                          child: Text('${book}'),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const VerticalDivider();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: MARGIN_MEDIUM_3,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: MARGIN_MEDIUM_2,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(builder: (context, setStated) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.all(MARGIN_MEDIUM_2),
                                  child: Text(
                                    'Sort by',
                                    style: TextStyle(
                                      fontSize: TEXT_REGULAR_2X,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Divider(),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: SortBy.values.length,
                                  itemBuilder: (context, index) {
                                    var sortBy = SortBy.values[index];

                                    return RadioListTile(
                                      value: index,
                                      groupValue: groupValue,
                                      onChanged: (value) {
                                        _onChangedSortBy(sortBy, index);
                                        setStated(() {});
                                      },
                                      title: Text('${sortBy.name}'),
                                    );
                                  },
                                ),
                              ],
                            );
                          });
                        },
                      );
                    },
                    child: Icon(Icons.sort),
                  ),
                  SizedBox(
                    width: MARGIN_MEDIUM,
                  ),
                  Text(
                    'Sort by : Recent ',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      debugPrint('show group value :: $groupValue');
                      return StatefulBuilder(builder: (context, setStated) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(
                                MARGIN_LARGE,
                              ),
                              child: Text(
                                'View as',
                                style: TextStyle(
                                  fontSize: TEXT_REGULAR_2X,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Divider(),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: ViewAs.values.length,
                              itemBuilder: (context, index) {
                                var viewAs = ViewAs.values[index];

                                return RadioListTile(
                                  value: index,
                                  groupValue: groupValue,
                                  onChanged: (value) {
                                    _onTapViewas(viewAs, index);
                                    // groupValue = index;
                                    // debugPrint('group value ::: $groupValue');
                                    setStated(() {});
                                  },
                                  title: Text('${viewAs.name}'),
                                );
                              },
                            ),
                          ],
                        );
                      });
                    },
                  );
                },
                child: Icon(() {
                  switch (viewAs) {
                    case ViewAs.List:
                      return Icons.list;
                    case ViewAs.LargeGrid:
                      return Icons.grid_3x3;
                    case ViewAs.SmallGrid:
                      return Icons.grid_4x4;
                  }
                }()),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MARGIN_MEDIUM_3,
        ),
        SizedBox(
          child: () {
            switch (viewAs) {
              case ViewAs.List:
                return ListViewSection(bookList: widget.booklist);
              case ViewAs.LargeGrid:
                return LargeGridViewSection(bookList: widget.booklist);
              case ViewAs.SmallGrid:
                return SmallGridViewSection(bookList: widget.booklist);
            }
          }(),
        )
      ],
    );
  }
}

class ListViewSection extends StatelessWidget {
  const ListViewSection({
    Key? key,
    required this.bookList,
  }) : super(key: key);

  final List<BookVO>? bookList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: MARGIN_LARGE,
      ),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: bookList?.length ?? 0,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var book = bookList?[index];

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 60,
                    height: 100,
                    child: CachedNetworkImage(
                      imageUrl: '${book?.bookImage}',
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    width: MARGIN_MEDIUM_2,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: Text(
                          '${book?.title}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: TEXT_REGULAR,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MARGIN_SMALL,
                      ),
                      Text(
                        '${book?.author}',
                        style: TextStyle(
                          fontSize: TEXT_SMALL,
                        ),
                      ),
                      SizedBox(
                        height: MARGIN_SMALL,
                      ),
                      Text(
                        '${book?.author}',
                        style: TextStyle(
                          fontSize: TEXT_SMALL,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.file_download_outlined,
                  ),
                  SizedBox(
                    width: MARGIN_XL_LARGE,
                  ),
                  Icon(
                    FontAwesomeIcons.ellipsis,
                  ),
                ],
              ),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: MARGIN_LARGE,
          );
        },
      ),
    );
  }
}

class LargeGridViewSection extends StatelessWidget {
  const LargeGridViewSection({
    Key? key,
    required this.bookList,
  }) : super(key: key);

  final List<BookVO>? bookList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: MARGIN_MEDIUM_2,
      ),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1 / 1.55,
          // crossAxisSpacing: 5,
          // mainAxisSpacing: 5,
          // mainAxisExtent: 150,
        ),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: bookList?.length,
        itemBuilder: (context, index) {
          var book = bookList?[index];
          return LargeBookViewItem(
            book: book,
            onTapSeeMore: () {},
          );
        },
      ),
    );
  }
}

class SmallGridViewSection extends StatelessWidget {
  const SmallGridViewSection({
    Key? key,
    required this.bookList,
  }) : super(key: key);

  final List<BookVO>? bookList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: MARGIN_MEDIUM_2,
      ),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1 / 1.8,
          // crossAxisSpacing: 5,
          // mainAxisSpacing: 5,
          // mainAxisExtent: 150,
        ),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: bookList?.length,
        itemBuilder: (context, index) {
          var book = bookList?[index];
          return BookViewItem(
            book: book,
            onTapSeeMore: () {},
            onTapBook: (book){},
          );
        },
      ),
    );
  }
}
