import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/data/vos/buy_link_vo.dart';
import 'package:library_app/data/vos/list_vo.dart';
import 'package:library_app/data/vos/over_view_vo.dart';
import 'package:library_app/pages/home_name.dart';
import 'package:library_app/persistence/hive_constants.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(OverViewVOAdapter());
  Hive.registerAdapter(ListVOAdapter());
  Hive.registerAdapter(BookVOAdapter());
  Hive.registerAdapter(BuyLinkVOAdapter());

  await Hive.openBox(BOX_NAME_OVERVIEW_VO);
  await Hive.openBox(BOX_NAME_BOOK_VO);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}
