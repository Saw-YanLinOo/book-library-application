import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:library_app/blocs/home_page_bloc.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/data/vos/list_vo.dart';
import 'package:library_app/dummy_data/data.dart';
import 'package:library_app/pages/book_detail_page.dart';
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
      children: [
        const SizedBox(
          height: MARGIN_XXXXL_LARGE,
        ),
        Selector<HomePageBloc, List<BookVO>?>(
            selector: (context, bloc) => bloc.previewbooklist,
            builder: (context, bookList, child) {
              return SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                child: bookList == null || bookList.isEmpty
                    ? Lottie.asset('assets/book.json')
                    : Swiper(
                        itemCount: bookList.length,
                        viewportFraction: 0.5,
                        scale: 0.6,
                        loop: false,
                        itemBuilder: (context, index) {
                          var book = bookList[index];

                          return Container(
                            child: Stack(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: book.bookImage ?? '',
                                  fit: BoxFit.fill,
                                  errorWidget: (context, _, __) {
                                    return Lottie.asset('assets/book.json');
                                  },
                                ),
                                const Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Icon(
                                    FontAwesomeIcons.ellipsis,
                                    color: Colors.white,
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: MARGIN_XL_LARGE,
                                      height: MARGIN_XL_LARGE,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(
                                            MARGIN_CARD_MEDIUM),
                                      ),
                                      child: const Icon(
                                        Icons.headphones_outlined,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 15,
                                  child: Container(
                                    padding:
                                        const EdgeInsets.all(MARGIN_MEDIUM),
                                    child: Container(
                                      width: MARGIN_XL_LARGE,
                                      height: MARGIN_XL_LARGE,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(
                                            MARGIN_CARD_MEDIUM),
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
            }),
        const SizedBox(
          height: MARGIN_LARGE,
        ),
        TabBarViewWidget(
          tabController: _tabController,
          onTap: (index) {},
          tabItems: const [
            Tab(text: EBOOKS_TEXT),
            Tab(text: AUDIOBOOK_TEXT),
          ],
        ),
        const SizedBox(
          height: MARGIN_CARD_MEDIUM_2,
        ),
        Selector<HomePageBloc, List<ListVO>?>(
          selector: (_, bloc) => bloc.overviewlist,
          builder: (context, lists, child) {
            debugPrint('list lenget :::::::::::: ${lists?.length}');

            return lists == null
                ? const CircularProgressIndicator()
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: lists.length,
                    padding: const EdgeInsets.symmetric(
                        vertical: MARGIN_CARD_MEDIUM),
                    itemBuilder: (context, index) {
                      var list = lists[index];
                      return TitleAndBookListView(
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
        ),
      ],
    );
  }
}

class TitleAndBookListView extends StatelessWidget {
  const TitleAndBookListView({
    Key? key,
    this.mTitle,
    this.mBookList,
    required this.onTapForward,
    required this.onTapBook,
  }) : super(key: key);

  final String? mTitle;
  final List<BookVO>? mBookList;
  final Function onTapForward;
  final Function(BookVO?) onTapBook;
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
              reverse: true,
              itemCount: mBookList?.length,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: MARGIN_CARD_MEDIUM),
              itemBuilder: (context, index) {
                var book = mBookList?[index];
                return BookViewItem(
                  book: book,
                  onTapSeeMore: () {
                    onTapBook(book);
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
