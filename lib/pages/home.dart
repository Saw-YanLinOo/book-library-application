import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/dummy_data/data.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BookVO>? bannerList = [...audioBookList, ...ebookList];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: HomeTitleView(
            onTapSummit: (text) {},
          ),
        ),
      ),
      body: ListView(
        children: [
          Swiper(
            pagination: const SwiperPagination(margin: EdgeInsets.all(5.0)),
            viewportFraction: 0.8,
            scale: 0.8,
            outer: true,
            itemHeight: MediaQuery.of(context).size.height / 2,
            itemCount: bannerList?.length ?? 0,
            itemBuilder: (context, index) {
              var book = bannerList?[index];

              return Container();
            },
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
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          suffix: Image.asset('assets/images/p_image.png'),
          hintText: 'Search Play Book',
        ),
        onSubmitted: (text) {
          onTapSummit(text);
        },
      ),
    );
  }
}
