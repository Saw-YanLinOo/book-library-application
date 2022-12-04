import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'test_data/test_data.dart';

Future<void> libraryPageTest(WidgetTester tester) async {
  expect(find.text(TEST_DATA_LIST_NAME_ONE), findsOneWidget);
  expect(find.text(TEST_DATA_LIST_NAME_TWO), findsOneWidget);
  expect(find.text(TEST_DATA_LIST_NAME_THREE), findsOneWidget);

  testBookNameAndAuthor(
    bookName: TEST_DATA_BOOK_NAME_ONE,
    bookAuthor: TEST_DATA_BOOK_AUTHOR_ONE,
  );
  testBookNameAndAuthor(
    bookName: TEST_DATA_BOOK_NAME_TWO,
    bookAuthor: TEST_DATA_BOOK_AUTHOR_TWO,
  );
  testBookNameAndAuthor(
    bookName: TEST_DATA_BOOK_NAME_THREE,
    bookAuthor: TEST_DATA_BOOK_AUTHOR_THREE,
  );

  await tester.tap(find.text(TEST_DATA_LIST_NAME_ONE));
  await tester.pumpAndSettle(const Duration(seconds: 3));
  testBookNameAndAuthor(
    bookName: TEST_DATA_BOOK_NAME_ONE,
    bookAuthor: TEST_DATA_BOOK_AUTHOR_ONE,
  );

  await tester.tap(find.byKey(KeyRemoveCategory));
  await tester.pumpAndSettle(const Duration(seconds: 3));
  testBookNameAndAuthor(
    bookName: TEST_DATA_BOOK_NAME_ONE,
    bookAuthor: TEST_DATA_BOOK_AUTHOR_ONE,
  );
  testBookNameAndAuthor(
    bookName: TEST_DATA_BOOK_NAME_TWO,
    bookAuthor: TEST_DATA_BOOK_AUTHOR_TWO,
  );
  testBookNameAndAuthor(
    bookName: TEST_DATA_BOOK_NAME_THREE,
    bookAuthor: TEST_DATA_BOOK_AUTHOR_THREE,
  );

  await tester.tap(find.byKey(KeySortBy));
  await tester.pumpAndSettle(const Duration(seconds: 3));
  expect(find.text('Sort by'), findsOneWidget);

  await tester.tap(find.byKey(KeySortByRecently));
  await tester.pumpAndSettle(const Duration(seconds: 3));
  testBookNameAndAuthor(
    bookName: TEST_DATA_BOOK_NAME_THREE,
    bookAuthor: TEST_DATA_BOOK_AUTHOR_THREE,
  );

  await tester.tap(find.byKey(KeySortBy));
  await tester.pumpAndSettle(const Duration(seconds: 3));

  await tester.tap(find.byKey(KeySortByTitle));
  await tester.pumpAndSettle(const Duration(seconds: 3));
  testBookNameAndAuthor(
    bookName: TEST_DATA_BOOK_NAME_ONE,
    bookAuthor: TEST_DATA_BOOK_AUTHOR_ONE,
  );

  await tester.tap(find.byKey(KeySortBy));
  await tester.pumpAndSettle(const Duration(seconds: 3));

  await tester.tap(find.byKey(KeySortByAuthor));
  await tester.pumpAndSettle(const Duration(seconds: 3));
  testBookNameAndAuthor(
    bookName: TEST_DATA_BOOK_NAME_ONE,
    bookAuthor: TEST_DATA_BOOK_AUTHOR_ONE,
  );

  await tester.tap(find.byKey(KeyViewAs));
  await tester.pumpAndSettle(const Duration(seconds: 3));
  expect(find.text('View as'), findsOneWidget);

  await tester.tap(find.byKey(KeyViewAsLargeGrid));
  await tester.pumpAndSettle(const Duration(seconds: 5));
  expect(find.byKey(KeyLargeGridVeiw), findsOneWidget);

  await tester.tap(find.byKey(KeyViewAs));
  await tester.pumpAndSettle(const Duration(seconds: 3));

  await tester.tap(find.byKey(KeyViewAsSmallGrid));
  await tester.pumpAndSettle(const Duration(seconds: 5));
  expect(find.byKey(KeySmallGridVeiw), findsOneWidget);

  await tester.tap(find.byKey(KeyViewAs));
  await tester.pumpAndSettle(const Duration(seconds: 3));

  await tester.tap(find.byKey(KeyViewAsList));
  await tester.pumpAndSettle(const Duration(seconds: 5));
  expect(find.byKey(KeyListVeiw), findsOneWidget);
}

void testBookNameAndAuthor({
  required String bookName,
  required String bookAuthor,
}) {
  expect(find.text(bookName), findsOneWidget);
  expect(find.text(bookAuthor), findsOneWidget);
}
