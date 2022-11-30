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
    await searchBookAndCheckInSwipper(tester);
  });
}

Future<void> searchBookAndCheckInSwipper(WidgetTester tester) async {
  expect(find.byKey(KEY_HOME_PAGE_SEARCH_FIELD), findsOneWidget);
  await tester.tap(find.byKey(KEY_HOME_PAGE_SEARCH_FIELD));
  await tester.pumpAndSettle(const Duration(seconds: 5));
  await tester.enterText(find.byType(TextField), TEST_DATA_SEARCH_NAME);
  await tester.pumpAndSettle(const Duration(seconds: 5));
  await tester.testTextInput.receiveAction(TextInputAction.done);
  await tester.pumpAndSettle(const Duration(seconds: 5));

  expect(find.text(TEST_DATA_SEARCH_BOOK_NAME), findsOneWidget);
  await tester.tap(find.text(TEST_DATA_SEARCH_BOOK_NAME));
  await tester.pumpAndSettle(const Duration(seconds: 5));

  expect(find.text(TEST_DATA_SEARCH_BOOK_NAME), findsOneWidget);
  expect(find.text(TEST_DATA_SEARCH_BOOK_AUTHOR), findsOneWidget);
  await tester.tap(find.byKey(KEY_BOOK_DETAIL_POP_ICON));

  await tester.pumpAndSettle(const Duration(seconds: 5));

  await tester.tap(find.byKey(KEY_SEARCH_PAGE_POP_ICON));
  await tester.pumpAndSettle(const Duration(seconds: 5));
  expect(find.byKey(KEY_SWIPPER_SEARCH_BOOK_NAME), findsOneWidget);
}

Future<void> tapBookToDetailPageAndCheckInSwipper(WidgetTester tester) async {
  /// ListName One(string), BookName One(string), BookAuthor One(string),
  /// Swipper BookKey One(key), Scroll Offset For BookOne(offset)

  // Book One
  await checkBook(
    tester: tester,
    listName: TEST_DATA_LIST_NAME_ONE,
    bookName: TEST_DATA_BOOK_NAME_ONE,
    bookAuthor: TEST_DATA_BOOK_AUTHOR_ONE,
    swipperKey: KEY_SWIPPER_BOOK_NAME_ONE,
    detaX: 0.0,
    detaY: 1900,
  );
  // Book Two
  await checkBook(
    tester: tester,
    listName: TEST_DATA_LIST_NAME_TWO,
    bookName: TEST_DATA_BOOK_NAME_TWO,
    bookAuthor: TEST_DATA_BOOK_AUTHOR_TWO,
    swipperKey: KEY_SWIPPER_BOOK_NAME_TWO,
    detaX: 0.0,
    detaY: 2000,
  );
  // Book Three
  await checkBook(
    tester: tester,
    listName: TEST_DATA_LIST_NAME_THREE,
    bookName: TEST_DATA_BOOK_NAME_THREE,
    bookAuthor: TEST_DATA_BOOK_AUTHOR_THREE,
    swipperKey: KEY_SWIPPER_BOOK_NAME_THREE,
    detaX: 0.0,
    detaY: 4000,
  );
}

Future<void> checkBook({
  required WidgetTester tester,
  required String listName,
  required String bookName,
  required String bookAuthor,
  required Key swipperKey,
  required double detaX,
  required double detaY,
}) async {
  await tester.dragUntilVisible(
    find.text(listName),
    find.byKey(KEY_HOME_PAGE_LIST_VIEW),
    Offset(detaX, -detaY),
  );
  await tester.pumpAndSettle(const Duration(seconds: 5));

  expect(find.text(bookName), findsOneWidget);
  await tester.pumpAndSettle(const Duration(seconds: 5));

  await tester.tap(find.text(bookName));

  await tester.pumpAndSettle(const Duration(seconds: 5));

  expect(find.text(bookName), findsOneWidget);
  expect(find.text(bookAuthor), findsOneWidget);
  await tester.tap(find.byKey(KEY_BOOK_DETAIL_POP_ICON));

  await tester.pumpAndSettle(const Duration(seconds: 5));

  await tester.dragUntilVisible(
    find.byKey(KEY_HOME_PAGE_TAB_BAR_SECTION),
    find.byKey(KEY_HOME_PAGE_LIST_VIEW),
    Offset(detaX, detaY),
  );
  await tester.pumpAndSettle(const Duration(seconds: 5));

  await tester.dragUntilVisible(
    find.byKey(swipperKey),
    find.byKey(KEY_HOME_PAGE_LIST_VIEW),
    const Offset(0.0, 100.0),
  );
  await tester.pumpAndSettle(const Duration(seconds: 5));
}
