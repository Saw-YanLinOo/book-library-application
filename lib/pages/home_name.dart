import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/dummy_data/data.dart';
import 'package:library_app/pages/book_detail_page.dart';
import 'package:library_app/pages/library_page.dart';
import 'package:library_app/resourses/dimens.dart';
import 'package:library_app/resourses/strings.dart';
import 'package:library_app/widgets/Tab_bar_view_widget.dart';
import 'package:lottie/lottie.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 1;
  static const pages = [
    HomePage(),
    LibraryPage(),
  ];

  _onChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: MARGIN_MEDIUM,
            vertical: MARGIN_CARD_MEDIUM_2,
          ),
          child: HomeTitleView(
            onTapSummit: (text) {},
          ),
        ),
      ),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: _onChanged,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: HOME_TEXT,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books_outlined),
            label: LIBRARY_TEXT,
          )
        ],
      ),
    );
  }
}

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
    return ListView(
      children: [
        SizedBox(
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
                      imageUrl: book?.posterPath ?? '',
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
                          child: Icon(
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
        SizedBox(
          height: MARGIN_CARD_MEDIUM_2,
        ),
        TitleAndBookListView(
          mTitle: "More like Don't Make Me Think, Revist",
          mBookList: ebookList,
        ),
        SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        TitleAndBookListView(
          mTitle: "More like Don't Make Me Think, Revist",
          mBookList: audioBookList,
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
  }) : super(key: key);

  final String? mTitle;
  final List<BookVO>? mBookList;
  @override
  Widget build(BuildContext context) {
    return Column(
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
                  style: TextStyle(
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
                  imageUrl: book?.posterPath ?? '',
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
            '${book?.name}',
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

class HomeTitleView extends StatelessWidget {
  final Function(String) onTapSummit;
  const HomeTitleView({
    Key? key,
    required this.onTapSummit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: TextFormField(
        decoration: InputDecoration(
          icon: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: const Icon(Icons.search),
          ),
          border: InputBorder.none,
          suffixIcon: Lottie.asset(
            'assets/young-boy.json',
            height: 32,
          ),
          hintText: 'Search Play Book',
        ),
        // onSubmitted: (text) {
        //   onTapSummit(text);
        // },
      ),
    );
  }
}
