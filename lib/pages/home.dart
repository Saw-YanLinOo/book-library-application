import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:library_app/blocs/home_bloc.dart';
import 'package:library_app/data/model/book_model.dart';
import 'package:library_app/data/model/book_model_impl.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/dummy_data/data.dart';
import 'package:library_app/pages/book_detail_page.dart';
import 'package:library_app/pages/home_page.dart';
import 'package:library_app/pages/library_page.dart';
import 'package:library_app/resourses/dimens.dart';
import 'package:library_app/resourses/strings.dart';
import 'package:library_app/widgets/Tab_bar_view_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
      // body: pages[currentIndex],
      body: Selector<HomeBloc, int>(
        selector: (context, bloc) => bloc.currentIndex,
        builder: (context, value, child) =>
            value == 0 ? const HomePage() : const LibraryPage(),
      ),
      bottomNavigationBar: Selector<HomeBloc, int>(
        selector: (context, bloc) => bloc.currentIndex,
        builder: (context, value, child) => BottomNavigationBar(
          currentIndex: value,
          onTap: (value) {
            HomeBloc bloc = Provider.of<HomeBloc>(context, listen: false);
            bloc.onChanged(value);
          },
          items: const [
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
