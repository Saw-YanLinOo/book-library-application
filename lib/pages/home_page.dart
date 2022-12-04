import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:library_app/blocs/add_to_shelf_bloc.dart';
import 'package:library_app/blocs/home_page_bloc.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/data/vos/list_vo.dart';
import 'package:library_app/dummy_data/data.dart';
import 'package:library_app/pages/add_to_shelf_page.dart';
import 'package:library_app/pages/book_detail_page.dart';
import 'package:library_app/pages/bottomsheet_page/book_setting_shelf_view.dart';
import 'package:library_app/pages/title_and_book_page.dart';
import 'package:library_app/resourses/dimens.dart';
import 'package:library_app/resourses/strings.dart';
import 'package:library_app/viewitems/book_view_item.dart';
import 'package:library_app/widgets/Tab_bar_view_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: const Key("HOME_PAGE_LIST_VIEW"),
      children: [
        const SizedBox(
          height: MARGIN_XXXXL_LARGE,
        ),
        Selector<HomePageBloc, List<BookVO>?>(
            selector: (context, bloc) => bloc.previewbooklist,
            builder: (context, bookList, child) {
              return BookSwipperSetion(
                key: Key("HOME_PAGE_BOOK_SWIPPER_SECTION"),
                bookList: bookList,
              );
            }),
        const SizedBox(
          height: MARGIN_LARGE,
        ),
        Selector<HomePageBloc, int>(
            selector: (context, bloc) => bloc.bookType,
            builder: (context, value, child) {
              _tabController.index = value;

              return TabBarViewWidget(
                key: const Key("HOME_PAGE_TAB_BAR_SECTION"),
                tabController: _tabController,
                onTap: (index) {
                  context.read<HomePageBloc>().onChangedBookType(index);
                },
                tabItems: const [
                  Tab(text: EBOOKS_TEXT),
                  Tab(text: AUDIOBOOK_TEXT),
                ],
              );
            }),
        const SizedBox(
          height: MARGIN_CARD_MEDIUM_2,
        ),
        Selector<HomePageBloc, int>(
          selector: (context, bloc) => bloc.bookType,
          builder: (context, value, child) {
            return Selector<HomePageBloc, List<ListVO>?>(
              selector: (_, bloc) => bloc.overviewlist,
              builder: (context, lists, child) {
                debugPrint('list lenget :::::::::::: ${lists?.length}');

                return lists == null
                    ? const SizedBox()
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: lists.length,
                        padding: const EdgeInsets.symmetric(
                            vertical: MARGIN_CARD_MEDIUM),
                        itemBuilder: (context, index) {
                          var list = lists[index];
                          return TitleAndBookListView(
                            audio: value == 1,
                            mTitle: '${list.listName}',
                            mBookList: list.books,
                            onTapForward: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TitleAndBookPage(
                                    mBookList: list.books,
                                    mtitle: list.listName,
                                  ),
                                ),
                              );
                            },
                            onTapBookTitle: (book) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookDetailPage(
                                    mBook: book,
                                    listName: list.listName,
                                  ),
                                ),
                              );
                            },
                            onTapSeeMore: (book) {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) {
                                    return ChangeNotifierProvider.value(
                                        value: HomePageBloc(),
                                        builder: (context, child) {
                                          return BookSettingSheetView(
                                            book: book,
                                            onTapAboutThisBook: () {},
                                            onTapClose: () {
                                              Navigator.pop(context);
                                            },
                                            onTapAddToShelf: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddToShelfPage(
                                                    book: book,
                                                  ),
                                                ),
                                              );
                                            },
                                            onTapDelete: () {
                                              context
                                                  .read<HomePageBloc>()
                                                  .deleteBook(
                                                      book?.title ?? '');
                                            },
                                          );
                                        });
                                  });
                            },
                            onTapBook: (book) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookDetailPage(
                                    mBook: book,
                                    listName: list.listName,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
              },
            );
          },
        ),
      ],
    );
  }
}

class BookSwipperSetion extends StatelessWidget {
  const BookSwipperSetion({
    Key? key,
    this.bookList,
  }) : super(key: key);

  final List<BookVO>? bookList;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: bookList == null || (bookList?.isEmpty ?? true)
          ? const NoBookViewInSwipper(
              key: Key('KEY_NO_BOOK_VIEW_IN_SWIPPER'),
            )
          : Swiper(
              itemCount: bookList?.length ?? 0,
              viewportFraction: 0.5,
              scale: 0.6,
              loop: false,
              itemBuilder: (context, index) {
                var book = bookList?[index];

                return Container(
                  key: Key(book?.title ?? ''),
                  child: Stack(
                    children: [
                      SizedBox(
                        // width: 200,
                        height: MediaQuery.of(context).size.height / 3,
                        child: CachedNetworkImage(
                          imageUrl: book?.bookImage ?? '',
                          fit: BoxFit.fitHeight,
                          errorWidget: (context, _, __) {
                            return Lottie.asset('assets/book.json');
                          },
                        ),
                      ),
                      const Positioned(
                        top: 0,
                        right: 0,
                        child: Icon(
                          FontAwesomeIcons.ellipsis,
                          color: Colors.white,
                        ),
                      ),
                      // Positioned(
                      //   bottom: 0,
                      //   left: 0,
                      //   child: Container(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Container(
                      //       width: MARGIN_XL_LARGE,
                      //       height: MARGIN_XL_LARGE,
                      //       decoration: BoxDecoration(
                      //         color: Colors.black,
                      //         borderRadius:
                      //             BorderRadius.circular(MARGIN_CARD_MEDIUM),
                      //       ),
                      //       child: const Icon(
                      //         Icons.headphones_outlined,
                      //         color: Colors.white,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Positioned(
                        bottom: 0,
                        right: 15,
                        child: Container(
                          padding: const EdgeInsets.all(MARGIN_MEDIUM),
                          child: Container(
                            width: MARGIN_XL_LARGE,
                            height: MARGIN_XL_LARGE,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                                  BorderRadius.circular(MARGIN_CARD_MEDIUM),
                            ),
                            child: const Icon(
                              Icons.download_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

class NoBookViewInSwipper extends StatelessWidget {
  const NoBookViewInSwipper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //child: Lottie.asset('assets/book.json'),
      child: SizedBox(),
    );
  }
}

// class BookSettingSheetView extends StatelessWidget {
//   const BookSettingSheetView({
//     Key? key,
//     this.book,
//     required this.onTapDelete,
//     required this.onTapAddToShelf,
//   }) : super(key: key);

//   final BookVO? book;
//   final Function onTapDelete;
//   final Function onTapAddToShelf;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: MARGIN_CARD_MEDIUM,
//             vertical: MARGIN_MEDIUM_2,
//           ),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 width: 50,
//                 height: 80,
//                 child: CachedNetworkImage(
//                   imageUrl: '${book?.bookImage}',
//                   fit: BoxFit.fill,
//                 ),
//               ),
//               SizedBox(
//                 width: MARGIN_MEDIUM,
//               ),
//               Column(
//                 children: [
//                   Text(
//                     '${book?.title}',
//                     style: const TextStyle(
//                       fontSize: TEXT_REGULAR,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                   Text(
//                     '${book?.author}',
//                     style: const TextStyle(
//                       fontSize: TEXT_SMALL,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         Divider(),
//         ListTile(
//           onTap: () {
//             //onEdit();
//           },
//           leading: Icon(Icons.file_download_outlined),
//           title: Text(
//             'Download',
//             style: TextStyle(
//               fontSize: TEXT_SMALL,
//             ),
//           ),
//         ),
//         ListTile(
//           onTap: () {
//             onTapDelete();
//           },
//           leading: Icon(Icons.delete),
//           title: Text(
//             'Delete from your library',
//             style: TextStyle(
//               fontSize: TEXT_SMALL,
//             ),
//           ),
//         ),
//         ListTile(
//           onTap: () {
//             onTapAddToShelf();
//           },
//           leading: Icon(Icons.add),
//           title: Text(
//             'Add to Shelf',
//             style: TextStyle(
//               fontSize: TEXT_SMALL,
//             ),
//           ),
//         ),
//         ListTile(
//           onTap: () {
//             //onDelected();
//           },
//           leading: Icon(Icons.done),
//           title: Text(
//             'Make as read',
//             style: TextStyle(
//               fontSize: TEXT_SMALL,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

class TitleAndBookListView extends StatelessWidget {
  const TitleAndBookListView({
    Key? key,
    this.mTitle,
    this.audio,
    this.mBookList,
    required this.onTapForward,
    required this.onTapBook,
    required this.onTapSeeMore,
    required this.onTapBookTitle,
  }) : super(key: key);

  final String? mTitle;
  final bool? audio;
  final List<BookVO>? mBookList;
  final Function onTapForward;
  final Function(BookVO?) onTapBook;
  final Function(BookVO?) onTapSeeMore;
  final Function(BookVO?) onTapBookTitle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: HOME_PAGE_LIST_HEIGHT,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: MARGIN_CARD_MEDIUM_2,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Text(
                    mTitle ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: TEXT_REGULAR_2X,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  width: MARGIN_CARD_MEDIUM,
                ),
                InkWell(
                  onTap: () {
                    onTapForward();
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MARGIN_MEDIUM_2,
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
              key: const Key("BOOK_HORIZONTAL_SCROLL_VIEW"),
              reverse: true,
              itemCount: mBookList?.length,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: MARGIN_CARD_MEDIUM),
              itemBuilder: (context, index) {
                var book = mBookList?[index];
                book?.listName = mTitle;
                return BookViewItem(
                  book: book,
                  audio: audio,
                  onTapBook: (book) {
                    onTapBook(book);
                  },
                  onTapSeeMore: () {
                    onTapSeeMore(book);
                  },
                  onTapTitle: (book) {
                    onTapBookTitle(book);
                  },
                );
              },
            ),
          ),
          SizedBox(
            height: MARGIN_LARGE,
          ),
        ],
      ),
    );
  }
}
