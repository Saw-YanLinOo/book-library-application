import 'package:flutter/material.dart';
import 'package:library_app/blocs/home_bloc.dart';
import 'package:library_app/blocs/home_page_bloc.dart';
import 'package:library_app/blocs/library_page_bloc.dart';
import 'package:library_app/pages/home_page.dart';
import 'package:library_app/pages/library_page.dart';
import 'package:library_app/pages/search_page.dart';
import 'package:library_app/resourses/dimens.dart';
import 'package:library_app/resourses/strings.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _navigateToSearch(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SearchPage(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageBloc>(
      create: (context) => HomePageBloc(),
      child: ChangeNotifierProvider<LibraryPageBloc>(
        create: (context) => LibraryPageBloc(),
        child: Scaffold(
          backgroundColor: Colors.white,
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
                onTapSummit: (text) {
                  _navigateToSearch(context);
                },
              ),
            ),
          ),
          // body: pages[currentIndex],
          body: Selector<HomePageBloc, int>(
            selector: (context, bloc) => bloc.currentIndex,
            builder: (context, value, child) =>
                value == 0 ? const HomePage() : const LibraryPage(),
          ),
          bottomNavigationBar: Selector<HomePageBloc, int>(
            selector: (context, bloc) => bloc.currentIndex,
            builder: (context, value, child) => BottomNavigationBar(
              key: const Key('KEY_HOME_PAGE_BOTTOM_NAVIGATION_BAR'),
              backgroundColor: Colors.white,
              currentIndex: value,
              onTap: (value) {
                HomePageBloc bloc =
                    Provider.of<HomePageBloc>(context, listen: false);
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
        ),
      ),
    );
  }
}

class HomeTitleView extends StatelessWidget {
  final Function(String?) onTapSummit;
  const HomeTitleView({
    Key? key,
    required this.onTapSummit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: TextField(
        key: const Key('KEY_HOME_PAGE_SEARCH_FIELD'),
        readOnly: true,
        decoration: InputDecoration(
          icon: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: const Icon(Icons.search),
          ),
          border: InputBorder.none,
          // suffixIcon: Lottie.asset(
          //   'assets/young-boy.json',
          //   height: 32,
          // ),
          suffixIcon: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
            ),
            padding: const EdgeInsets.all(MARGIN_MEDIUM),
            child: Icon(
              Icons.person,
              size: 32,
              color: Colors.white,
            ),
          ),
          hintText: 'Search Play Book',
        ),
        onTap: () {
          onTapSummit(null);
        },
        // onSubmitted: (text) {
        //   onTapSummit(text);
        // },
      ),
    );
  }
}
