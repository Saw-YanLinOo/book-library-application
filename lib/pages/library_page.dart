import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:library_app/blocs/library_page_bloc.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/dummy_data/data.dart';
import 'package:library_app/pages/home.dart';
import 'package:library_app/pages/home_page.dart';
import 'package:library_app/pages/your_book_page.dart';
import 'package:library_app/pages/your_shelf_page.dart';
import 'package:library_app/resourses/dimens.dart';
import 'package:library_app/resourses/strings.dart';
import 'package:library_app/viewitems/book_view_item.dart';
import 'package:library_app/widgets/Tab_bar_view_widget.dart';
import 'package:provider/provider.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBarViewWidget(
          tabController: _tabController,
          onTap: (index) {
            LibraryPageBloc bloc = Provider.of(context, listen: false);
            bloc.onChanged(index);
          },
          tabItems: const [
            Tab(text: YOUR_BOOK_TEXT),
            Tab(text: YOUR_SHELVES_TEXT),
          ],
        ),
        SizedBox(
          height: MARGIN_LARGE,
        ),
        Selector<LibraryPageBloc, int>(
          selector: (context, bloc) => bloc.currentIndex,
          builder: (context, value, child) {
            return Expanded(
              child: Container(
                child: value == 0 ? YourBookPage() : YourShelfPage(),
              ),
            );
          },
        ),
      ],
    );
  }
}
