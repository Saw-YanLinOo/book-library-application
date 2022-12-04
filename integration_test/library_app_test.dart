import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:integration_test/integration_test.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/data/vos/buy_link_vo.dart';
import 'package:library_app/data/vos/list_vo.dart';
import 'package:library_app/data/vos/over_view_vo.dart';
import 'package:library_app/data/vos/shelf_vo.dart';
import 'package:library_app/main.dart';
import 'package:library_app/pages/home.dart';
import 'package:library_app/pages/home_page.dart';
import 'package:library_app/persistence/hive_constants.dart';

import 'home_page_test.dart';
import 'library_page_test.dart';
import 'search_page_test.dart';
import 'shelf_page_test.dart';
import 'test_data/test_data.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(BuyLinkVOAdapter());
  Hive.registerAdapter(BookVOAdapter());
  Hive.registerAdapter(ListVOAdapter());
  Hive.registerAdapter(OverViewVOAdapter());
  Hive.registerAdapter(ShelfVOAdapter());

  await Hive.openBox<OverViewVO>(BOX_NAME_OVERVIEW_VO);
  await Hive.openBox<BookVO>(BOX_NAME_BOOK_VO);
  await Hive.openBox<ShelfVO>(BOX_NAME_SHELF_VO);

  testWidgets("Library App Testing", (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await Future.delayed(const Duration(seconds: 2));

    await tester.pumpAndSettle(const Duration(seconds: 5));

    // Home
    expect(find.byType(Home), findsOneWidget);
    expect(find.byKey(KEY_HOME_PAGE_SEARCH_FIELD), findsOneWidget);
    expect(find.byKey(KEY_HOME_PAGE_BOTTOM_NAVIGATION_BAR), findsOneWidget);

    // Home Page
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byKey(KEY_HOME_PAGE_BOOK_SWIPPER_SECTION), findsOneWidget);
    expect(find.byKey(KEY_HOME_PAGE_TAB_BAR_SECTION), findsOneWidget);

    await tapBookToDetailPageAndCheckInSwipper(tester);

    await tester.tap(find.byKey(KEY_HOME_PAGE_LIBRARY_BOTTOM_NAVIGATION_BAR));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    // Library Page
    expect(find.byKey(KeyYourBooksTab), findsOneWidget);
    expect(find.byKey(KeyYourShelvesTab), findsOneWidget);

    await libraryPageTest(tester);

    await tester.tap(find.byKey(KeyYourShelvesTab));
    await tester.pumpAndSettle(const Duration(seconds: 3));

    await testShelfPage(tester);

    await tester.tap(find.byKey(KEY_HOME_PAGE_HOME_BOTTOM_NAVIGATION_BAR));
    await tester.pumpAndSettle(const Duration(seconds: 3));

    await searchBookTest(tester);
  });
}
