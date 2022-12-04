import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'test_data/test_data.dart';

Future<void> tapBookToDetailPageAndCheckInSwipper(WidgetTester tester) async {
  /// ListName One(string), BookName One(string), BookAuthor One(string),
  /// Swipper BookKey One(key), Scroll Offset For BookOne(offset)

  // Book One
  await testListNameBookNameNavitateToDetailAndCheckInSwipper(
    tester: tester,
    listName: TEST_DATA_LIST_NAME_ONE,
    bookName: TEST_DATA_BOOK_NAME_ONE,
    bookAuthor: TEST_DATA_BOOK_AUTHOR_ONE,
    bookDescription: TEST_DATA_BOOK_DESCRIPTION_ONE,
    swipperKey: KEY_SWIPPER_BOOK_NAME_ONE,
    detaX: 0.0,
    detaY: 1900,
  );

  // Book Two
  await testListNameBookNameNavitateToDetailAndCheckInSwipper(
    tester: tester,
    listName: TEST_DATA_LIST_NAME_TWO,
    bookName: TEST_DATA_BOOK_NAME_TWO,
    bookAuthor: TEST_DATA_BOOK_AUTHOR_TWO,
    bookDescription: TEST_DATA_BOOK_DESCRIPTION_TWO,
    swipperKey: KEY_SWIPPER_BOOK_NAME_TWO,
    detaX: 0.0,
    detaY: 2000,
  );

  // Book Three
  await testListNameBookNameNavitateToDetailAndCheckInSwipper(
    tester: tester,
    listName: TEST_DATA_LIST_NAME_THREE,
    bookName: TEST_DATA_BOOK_NAME_THREE,
    bookAuthor: TEST_DATA_BOOK_AUTHOR_THREE,
    bookDescription: TEST_DATA_BOOK_DESCRIPTION_THREE,
    swipperKey: KEY_SWIPPER_BOOK_NAME_THREE,
    detaX: 0.0,
    detaY: 4000,
  );
}

Future<void> testListNameBookNameNavitateToDetailAndCheckInSwipper({
  required WidgetTester tester,
  required String listName,
  required String bookName,
  required String bookAuthor,
  required String bookDescription,
  required Key swipperKey,
  required double detaX,
  required double detaY,
}) async {
  await tester.dragUntilVisible(
    find.text(listName),
    find.byKey(KEY_HOME_PAGE_LIST_VIEW),
    Offset(detaX, -detaY),
  );
  await tester.pumpAndSettle(const Duration(seconds: 3));

  expect(find.text(bookName), findsOneWidget);
  await tester.pumpAndSettle(const Duration(seconds: 3));

  await tester.tap(find.text(bookName));

  await tester.pumpAndSettle(const Duration(seconds: 3));

  expect(find.text(bookName), findsOneWidget);
  expect(find.text(bookAuthor), findsOneWidget);
  expect(find.text(bookDescription), findsOneWidget);
  expect(find.text('Free sample'), findsOneWidget);
  expect(find.text('Add to whishlist'), findsOneWidget);
  expect(find.text('About this ebook'), findsOneWidget);
  expect(find.text('Ratings and reviews'), findsOneWidget);

  await tester.tap(find.byKey(KEY_BOOK_DETAIL_POP_ICON));

  await tester.pumpAndSettle(const Duration(seconds: 3));

  // await tester.dragUntilVisible(
  //   find.byKey(KEY_HOME_PAGE_TAB_BAR_SECTION),
  //   find.byKey(KEY_HOME_PAGE_LIST_VIEW),
  //   Offset(detaX, detaY),
  // );
  // await tester.pumpAndSettle(const Duration(seconds: 3));

  // await tester.dragUntilVisible(
  //   find.byKey(swipperKey),
  //   find.byKey(KEY_HOME_PAGE_LIST_VIEW),
  //   const Offset(0.0, 100.0),
  // );
  // await tester.pumpAndSettle(const Duration(seconds: 3));
}
