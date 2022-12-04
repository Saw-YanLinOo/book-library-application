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

  // Book One
  expect(find.text(TEST_DATA_SEARCH_BOOK_NAME_ONE), findsOneWidget);
  expect(find.text(TEST_DATA_SEARCH_BOOK_AUTHOR_ONE), findsOneWidget);

  // Book Two
  expect(find.text(TEST_DATA_SEARCH_BOOK_NAME_TWO), findsOneWidget);
  expect(find.text(TEST_DATA_SEARCH_BOOK_AUTHOR_TWO), findsOneWidget);

  // Book Three
  expect(find.text(TEST_DATA_SEARCH_BOOK_NAME_THREE), findsOneWidget);
  expect(find.text(TEST_DATA_SEARCH_BOOK_AUTHOR_THREE), findsOneWidget);

  await tester.tap(find.byKey(KEY_SEARCH_PAGE_POP_ICON));
  await tester.pumpAndSettle(const Duration(seconds: 5));
}
