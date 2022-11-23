import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:library_app/blocs/home_page_bloc.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/data/vos/list_vo.dart';
import 'package:library_app/dummy_data/data.dart';
import 'package:library_app/pages/book_detail_page.dart';
import 'package:library_app/resourses/dimens.dart';
import 'package:library_app/resourses/strings.dart';
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
  List<BookVO>? bannerList = [...audioBookList, ...ebookList];
  int currentIndex = 0;
  late TabController _tabController;

  _onChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageBloc>(
      create: (context) => HomePageBloc(),
      child: ListView(
        children: [
          const SizedBox(
            height: MARGIN_XXXXL_LARGE,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: Swiper(
              itemCount: bannerList?.length ?? 0,
              viewportFraction: 0.5,
              scale: 0.6,
              loop: false,
              itemBuilder: (context, index) {
                var book = bannerList?[index];

                return Container(
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: book?.bookUri ?? '',
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
                              borderRadius:
                                  BorderRadius.circular(MARGIN_CARD_MEDIUM),
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
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
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
          ),
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
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: lists?.length,
                itemBuilder: (context, index) {
                  var list = lists?[index];
                  return TitleAndBookListView(
                    mTitle: '${list?.listName}',
                    mBookList: list?.books?.take(10).toList(),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class TitleAndBookListView extends StatelessWidget {
  const TitleAndBookListView({
    Key? key,
    this.mTitle,
    this.mBookList,
  }) : super(key: key);

  final String? mTitle;
  final List<BookVO>? mBookList;
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
                Icon(
                  Icons.arrow_forward_ios,
                ),
              ],
            ),
          ),
          SizedBox(
            height: MARGIN_MEDIUM,
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookDetailPage(mBook: book),
                        ));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BookViewItem extends StatelessWidget {
  const BookViewItem({
    Key? key,
    this.book,
    required this.onTapSeeMore,
  }) : super(key: key);

  final BookVO? book;
  final Function onTapSeeMore;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      padding: const EdgeInsets.symmetric(
        horizontal: MARGIN_MEDIUM,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                width: 120,
                height: 150,
                child: CachedNetworkImage(
                  imageUrl: book?.bookUri ?? '',
                  fit: BoxFit.fill,
                  errorWidget: (context, _, __) {
                    return Lottie.asset('assets/book.json');
                  },
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    onTapSeeMore();
                  },
                  child: const Icon(
                    FontAwesomeIcons.ellipsis,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Icon(
                      Icons.headphones_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            '${book?.title}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            '${book?.author}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
