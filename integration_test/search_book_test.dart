
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_data/test_data.dart';

Future<void> searchBookTest(WidgetTester tester) async {
  expect(find.byKey(KEY_HOME_PAGE_SEARCH_FIELD), findsOneWidget);
  await tester.tap(find.byKey(KEY_HOME_PAGE_SEARCH_FIELD));
  await tester.pumpAndSettle(const Duration(seconds: 5));
  await tester.enterText(find.byType(TextField), TEST_DATA_SEARCH_NAME);
  await tester.pumpAndSettle(const Duration(seconds: 5));
  await tester.testTextInput.receiveAction(TextInputAction.done);
  await tester.pumpAndSettle(const Duration(seconds: 5));

  expect(find.text(TEST_DATA_SEARCH_BOOK_NAME_ONE), findsOneWidget);
  expect(find.text(TEST_DATA_SEARCH_BOOK_AUTHOR_ONE), findsOneWidget);
  expect(find.text(TEST_DATA_SEARCH_BOOK_NAME_TWO), findsOneWidget);
  expect(find.text(TEST_DATA_SEARCH_BOOK_AUTHOR_TWO), findsOneWidget);
  expect(find.text(TEST_DATA_SEARCH_BOOK_NAME_THREE), findsOneWidget);
  expect(find.text(TEST_DATA_SEARCH_BOOK_AUTHOR_THREE), findsOneWidget);
  expect(find.text(TEST_DATA_SEARCH_BOOK_NAME_FOUR), findsOneWidget);
  expect(find.text(TEST_DATA_SEARCH_BOOK_AUTHOR_FOUR), findsOneWidget);
  expect(find.text(TEST_DATA_SEARCH_BOOK_NAME_FIVE), findsOneWidget);
  expect(find.text(TEST_DATA_SEARCH_BOOK_AUTHOR_FIVE), findsOneWidget);
  expect(find.text(TEST_DATA_SEARCH_BOOK_NAME_SIX), findsOneWidget);
  expect(find.text(TEST_DATA_SEARCH_BOOK_AUTHOR_SIX), findsOneWidget);
  expect(find.text(TEST_DATA_SEARCH_BOOK_NAME_SEVEN), findsOneWidget);
  expect(find.text(TEST_DATA_SEARCH_BOOK_AUTHOR_SEVEN), findsOneWidget);
  expect(find.text(TEST_DATA_SEARCH_BOOK_NAME_EIGHT), findsOneWidget);
  expect(find.text(TEST_DATA_SEARCH_BOOK_AUTHOR_EIGHT), findsOneWidget);
  expect(find.text(TEST_DATA_SEARCH_BOOK_NAME_NINE), findsOneWidget);
  expect(find.text(TEST_DATA_SEARCH_BOOK_AUTHOR_NINE), findsOneWidget);
  expect(find.text(TEST_DATA_SEARCH_BOOK_NAME_TEN), findsOneWidget);
  expect(find.text(TEST_DATA_SEARCH_BOOK_AUTHOR_TEN), findsOneWidget);

  await tester.tap(find.byKey(KEY_SEARCH_PAGE_POP_ICON));
  await tester.pumpAndSettle(const Duration(seconds: 5));
}
