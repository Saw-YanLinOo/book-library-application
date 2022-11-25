import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:library_app/blocs/home_bloc.dart';
import 'package:library_app/blocs/home_page_bloc.dart';
import 'package:library_app/blocs/library_page_bloc.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/data/vos/buy_link_vo.dart';
import 'package:library_app/data/vos/list_vo.dart';
import 'package:library_app/data/vos/over_view_vo.dart';
import 'package:library_app/data/vos/shelf_vo.dart';
import 'package:library_app/pages/home.dart';
import 'package:library_app/pages/library_page.dart';
import 'package:library_app/persistence/hive_constants.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(BuyLinkVOAdapter());
  Hive.registerAdapter(BookVOAdapter());
  Hive.registerAdapter(ListVOAdapter());
  Hive.registerAdapter(OverViewVOAdapter());
  Hive.registerAdapter(ShelfVOAdapter());

  await Hive.openBox<OverViewVO>(BOX_NAME_OVERVIEW_VO);
  await Hive.openBox<BookVO>(BOX_NAME_BOOK_VO);
  await Hive.openBox<ShelfVO>(BOX_NAME_SHELF_VO);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
