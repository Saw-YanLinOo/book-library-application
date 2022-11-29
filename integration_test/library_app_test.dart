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

  testWidgets("Tap three Book, Navigate to Book Detail and Check in Banner",
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await Future.delayed(const Duration(seconds: 2));

    await tester.pumpAndSettle(const Duration(seconds: 5));

    // Home
    expect(find.byType(Home), findsOneWidget);
    expect(find.byKey(KEY_HOME_PAGE_SEARCH_FIELD), findsOneWidget);
    expect(find.byKey(KEY_HOME_PAGE_BOTTOM_NAVIGATION_BAR), findsOneWidget);

    // Home Page
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byKey(KEY_NO_BOOK_VIEW_IN_SWIPPER), findsOneWidget);

    // Book One
    expect(find.text(TEST_DATA_LIST_NAME_ONE), findsOneWidget);
    expect(find.text(TEST_DATA_BOOK_NAME_ONE), findsOneWidget);
    await tester.tap(find.text(TEST_DATA_BOOK_NAME_ONE));

    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(find.text(TEST_DATA_LIST_NAME_ONE), findsOneWidget);
    expect(find.text(TEST_DATA_BOOK_NAME_ONE), findsOneWidget);
    await tester.tap(find.byKey(KEY_BOOK_DETAIL_POP_ICON));

    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(find.byType(BookSwipperSetion), findsOneWidget);
    expect(find.byKey(KEY_SWIPPER_BOOK_NAME_ONE), findsOneWidget);

    // Book Two
    await tester.drag(find.text(TEST_DATA_LIST_NAME_TWO), Offset(0.0, 100.0));
    expect(find.text(TEST_DATA_LIST_NAME_TWO), findsOneWidget);
    expect(find.text(TEST_DATA_BOOK_NAME_TWO), findsOneWidget);
    await tester.tap(find.text(TEST_DATA_BOOK_NAME_TWO));

    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(find.text(TEST_DATA_LIST_NAME_TWO), findsOneWidget);
    expect(find.text(TEST_DATA_BOOK_NAME_TWO), findsOneWidget);
    await tester.tap(find.byKey(KEY_BOOK_DETAIL_POP_ICON));

    await tester.pumpAndSettle(const Duration(seconds: 5));

    await tester.drag(find.text(TEST_DATA_LIST_NAME_TWO), Offset(0.0, -100.0));
    expect(find.byType(BookSwipperSetion), findsOneWidget);
    expect(find.byKey(KEY_SWIPPER_BOOK_NAME_TWO), findsOneWidget);
  });
}
