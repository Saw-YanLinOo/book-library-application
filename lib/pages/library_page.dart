import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/dummy_data/data.dart';
import 'package:library_app/pages/home_name.dart';
import 'package:library_app/resourses/dimens.dart';
import 'package:library_app/resourses/strings.dart';
import 'package:library_app/widgets/Tab_bar_view_widget.dart';

enum ViewAs {
  list,
  largeGrid,
  smallGrid,
}

enum SortBy {
  recently,
  title,
  author,
}

class LibraryPage extends StatefulWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  List<BookVO>? selectedList;
  List<BookVO>? unSelectedList;
  ViewAs viewAs = ViewAs.list;
  List<BookVO>? bookList = [...ebookList, ...audioBookList];
  int groupValue = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
    unSelectedList = [...ebookList, ...audioBookList];
  }

  onTapCategory(BookVO? bookVO) {
    selectedList ??= [];
    selectedList?.add(bookVO ?? BookVO());
    unSelectedList?.remove(bookVO);

    setState(() {});
  }

  onRemoveCatgory() {
    selectedList = null;
    unSelectedList = [...ebookList, ...audioBookList];
    setState(() {});

    debugPrint('list :: ${unSelectedList}');
  }

  _onTapViewas(ViewAs mViewAs, int index) {
    viewAs = mViewAs;
    groupValue = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TabBarViewWidget(
          tabController: _tabController,
          onTap: (index) {},
          tabItems: const [
            Tab(text: YOUR_BOOK_TEXT),
            Tab(text: YOUR_SHELVES_TEXT),
          ],
        ),
        SizedBox(
          height: MARGIN_LARGE,
        ),
        Container(
          // padding: const EdgeInsets.symmetric(
          //   horizontal: MARGIN_CARD_MEDIUM_2,
          // ),
          child: SizedBox(
            height: MARGIN_XL_LARGE,
            child: ListView(
              scrollDirection: Axis.horizontal,
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
                      child: Chip(label: Text('${book?.author}')),
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
                          child: Text('${book?.author}'),
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
                          return Column(
                            children: [
                              Text(
                                'Sort by',
                                style: TextStyle(
                                  fontSize: TEXT_REGULAR_2X,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Divider(),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: SortBy.values.length,
                                itemBuilder: (context, index) {
                                  var viewAs = SortBy.values[index];

                                  return RadioListTile(
                                    value: index,
                                    groupValue: groupValue,
                                    onChanged: (value) {},
                                    title: Text('${viewAs.name}'),
                                  );
                                },
                              ),
                            ],
                          );
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
                      return StatefulBuilder(builder: (context, setState) {
                        return Column(
                          children: [
                            Text(
                              'View as',
                              style: TextStyle(
                                fontSize: TEXT_REGULAR_2X,
                                fontWeight: FontWeight.w700,
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
                                    groupValue = index;
                                    debugPrint('group value ::: $groupValue');
                                    setState(() {});
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
                    case ViewAs.list:
                      return Icons.list;
                    case ViewAs.largeGrid:
                      return Icons.grid_3x3;
                    case ViewAs.smallGrid:
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
              case ViewAs.list:
                return ListViewSection(bookList: bookList);
              case ViewAs.largeGrid:
                return LargeGridViewSection(bookList: bookList);
              case ViewAs.smallGrid:
                return SmallGridViewSection(bookList: bookList);
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
        horizontal: MARGIN_MEDIUM_2,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: bookList?.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var book = bookList?[index];

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 90,
                    height: 150,
                    child: CachedNetworkImage(
                      imageUrl: '${book?.bookUri}',
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    width: MARGIN_MEDIUM_2,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: Text(
                          '${book?.title}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: TEXT_REGULAR_2X,
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
                          fontSize: TEXT_REGULAR,
                        ),
                      ),
                      SizedBox(
                        height: MARGIN_SMALL,
                      ),
                      Text(
                        '${book?.author}',
                        style: TextStyle(
                          fontSize: TEXT_REGULAR,
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
          childAspectRatio: 1 / 1.2,
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
          childAspectRatio: 1 / 2,
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
          );
        },
      ),
    );
  }
}
