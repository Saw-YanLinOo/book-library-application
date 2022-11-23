import 'package:flutter/material.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/pages/home.dart';
import 'package:library_app/pages/home_page.dart';
import 'package:library_app/resourses/dimens.dart';
import 'package:library_app/viewitems/book_view_item.dart';

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
          childAspectRatio: 1 / 1.2,
          // crossAxisSpacing: 5,
          // mainAxisSpacing: 5,
          // mainAxisExtent: 200,
        ),
        padding: const EdgeInsets.symmetric(vertical: MARGIN_MEDIUM_2),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var book = widget.mBookList?[index];

          return BookViewItem(
            book: book,
            onTapSeeMore: () {},
          );
        },
      ),
    );
  }
}
