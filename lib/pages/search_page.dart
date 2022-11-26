import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:library_app/blocs/search_page_bloc.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/pages/book_detail_page.dart';
import 'package:library_app/resourses/dimens.dart';
import 'package:library_app/resourses/strings.dart';
import 'package:library_app/widgets/Tab_bar_view_widget.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
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
    return ChangeNotifierProvider<SearchPageBloc>(
      create: (context) => SearchPageBloc(),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            title: TextField(
              autofocus: true,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              onSubmitted: (value) {
                context.read<SearchPageBloc>().searchBook(value);
              },
            ),
          ),
          body: Selector<SearchPageBloc, List<BookVO>?>(
            selector: (context, bloc) => bloc.bookList,
            builder: (context, books, child) {
              if (books == null) {
                return const SizedBox();
              }

              if (books.isEmpty) {
                return const CircularProgressIndicator();
              }

              return ListView(
                children: [
                  SizedBox(
                    height: MARGIN_MEDIUM_2,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: MARGIN_LARGE),
                    child: TabBarViewWidget(
                      tabController: _tabController,
                      onTap: (index) {},
                      tabItems: const [
                        Tab(text: EBOOKS_TEXT),
                        Tab(text: AUDIOBOOK_TEXT),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MARGIN_CARD_MEDIUM,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: MARGIN_MEDIUM_2,
                    ),
                    child: Text(
                      'Results from Google Play',
                      style: TextStyle(
                        fontSize: TEXT_REGULAR_2X,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MARGIN_MEDIUM_2,
                  ),
                  ListViewSection(
                    bookList: books,
                    onTapBook: (book) {
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
                    onTapSeeMore: (book) {},
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

class ListViewSection extends StatelessWidget {
  const ListViewSection({
    Key? key,
    this.bookList,
    required this.onTapBook,
    required this.onTapSeeMore,
  }) : super(key: key);

  final List<BookVO>? bookList;
  final Function(BookVO?) onTapBook;
  final Function(BookVO?) onTapSeeMore;
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

          return GestureDetector(
            onTap: () {
              onTapBook(book);
            },
            child: Row(
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
                      width: MediaQuery.of(context).size.width / 1.6,
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
                      '${book?.ageGroup}',
                      style: TextStyle(
                        fontSize: TEXT_SMALL,
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
