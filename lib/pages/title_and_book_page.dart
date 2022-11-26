import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/pages/book_detail_page.dart';
import 'package:library_app/pages/home.dart';
import 'package:library_app/pages/home_page.dart';
import 'package:library_app/resourses/dimens.dart';
import 'package:library_app/viewitems/book_view_item.dart';
import 'package:library_app/viewitems/large_book_view_item.dart';

class TitleAndBookPage extends StatefulWidget {
  const TitleAndBookPage({
    Key? key,
    this.mtitle,
    this.mBookList,
  }) : super(key: key);

  final String? mtitle;
  final List<BookVO>? mBookList;
  @override
  State<TitleAndBookPage> createState() => _TitleAndBookPageState();
}

class _TitleAndBookPageState extends State<TitleAndBookPage> {
  showBottomSheet(
    BuildContext context,
    BookVO? bookVO, {
    required Function onTapAboutTheBook,
  }) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return LargeBookSettingSheetView(
            book: bookVO,
            onTapAboutTheBook: () {
              onTapAboutTheBook();
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        title: Text(
          '${widget.mtitle}',
          style: const TextStyle(
            fontSize: TEXT_REGULAR_2X,
            color: Colors.black,
          ),
        ),
      ),
      body: GridView.builder(
        itemCount: widget.mBookList?.length,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1 / 1.55,
          // crossAxisSpacing: 5,
          // mainAxisSpacing: 5,
          // mainAxisExtent: 200,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: MARGIN_MEDIUM,
          horizontal: MARGIN_MEDIUM_2,
        ),
        itemBuilder: (context, index) {
          var book = widget.mBookList?[index];

          return LargeBookViewItem(
            book: book,
            onTapBook: (){},
            onTapSeeMore: () {
              showBottomSheet(context, book, onTapAboutTheBook: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookDetailPage(
                      listName: widget.mtitle,
                      mBook: book,
                    ),
                  ),
                );
              });
            },
          );
        },
      ),
    );
  }
}

class LargeBookSettingSheetView extends StatelessWidget {
  const LargeBookSettingSheetView({
    Key? key,
    this.book,
    required this.onTapAboutTheBook,
  }) : super(key: key);

  final BookVO? book;
  final Function onTapAboutTheBook;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: MARGIN_CARD_MEDIUM,
            vertical: MARGIN_MEDIUM_2,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 50,
                height: 80,
                child: CachedNetworkImage(
                  imageUrl: '${book?.bookImage}',
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                width: MARGIN_MEDIUM,
              ),
              Column(
                children: [
                  Text(
                    '${book?.title}',
                    style: const TextStyle(
                      fontSize: TEXT_REGULAR,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    '${book?.author}',
                    style: const TextStyle(
                      fontSize: TEXT_SMALL,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(),
        ListTile(
          onTap: () {
            //onEdit();
          },
          leading: Icon(Icons.add_to_photos_outlined),
          title: Text(
            'Free sample',
            style: TextStyle(
              fontSize: TEXT_SMALL,
            ),
          ),
        ),
        ListTile(
          onTap: () {},
          leading: Icon(Icons.bookmark_add_outlined),
          title: Text(
            'Add to whishlist',
            style: TextStyle(
              fontSize: TEXT_SMALL,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            onTapAboutTheBook();
          },
          leading: Icon(Icons.book),
          title: Text(
            'About this book',
            style: TextStyle(
              fontSize: TEXT_SMALL,
            ),
          ),
        ),
      ],
    );
  }
}
