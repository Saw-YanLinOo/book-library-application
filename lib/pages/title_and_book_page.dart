import 'package:flutter/material.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/pages/home.dart';
import 'package:library_app/pages/home_page.dart';
import 'package:library_app/resourses/dimens.dart';

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
        title: Text(
          '${widget.mtitle}',
          style: const TextStyle(
            fontSize: TEXT_REGULAR_2X,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: widget.mBookList?.length,
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
