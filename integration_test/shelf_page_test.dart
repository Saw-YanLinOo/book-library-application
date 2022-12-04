import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'library_page_test.dart';
import 'test_data/test_data.dart';

Future<void> testShelfPage(WidgetTester tester) async {
  expect(find.text('No shelf'), findsOneWidget);

  await tester.tap(find.byKey(KeyCreateNewShelf));
  await tester.pumpAndSettle(const Duration(seconds: 3));

  expect(find.text('Create Shelf'), findsOneWidget);
  expect(find.byType(TextField), findsOneWidget);

  await tester.enterText(find.byType(TextField), CreateShelfName);
  await tester.pumpAndSettle(const Duration(seconds: 5));
  await tester.testTextInput.receiveAction(TextInputAction.done);
  await tester.pumpAndSettle(const Duration(seconds: 3));

  expect(find.text(CreateShelfName), findsOneWidget);
  expect(find.text(ZeroBookText), findsOneWidget);
  await tester.pumpAndSettle(const Duration(seconds: 3));

  await tester.tap(find.byKey(KeyYourBooksTab));
  await tester.pumpAndSettle(const Duration(seconds: 5));

  // Add to Shelf Book One
  await tester.tap(find.byKey(SeeMoreBookOne));
  await tester.pumpAndSettle(const Duration(seconds: 3));

  expect(find.text(TEST_DATA_BOOK_NAME_ONE), findsWidgets);
  expect(find.text(TEST_DATA_BOOK_AUTHOR_ONE), findsWidgets);
  expect(find.text('Download'), findsOneWidget);
  expect(find.text('Delete from your library'), findsOneWidget);
  expect(find.text('Add to Shelf'), findsOneWidget);
  expect(find.text('Make as read'), findsOneWidget);
  expect(find.text('About this book'), findsOneWidget);

  await tester.tap(find.text('Add to Shelf'));
  await tester.pumpAndSettle(const Duration(seconds: 3));

  expect(find.text(CreateShelfName), findsOneWidget);
  expect(find.text(ZeroBookText), findsOneWidget);
  await tester.tap(find.byType(Checkbox));
  await tester.pumpAndSettle(const Duration(seconds: 3));

  expect(find.byKey(KeyBookNameOne), findsOneWidget);
  expect(find.text(OneBookText), findsOneWidget);

  await tester.tap(find.byIcon(Icons.clear));
  await tester.pumpAndSettle(const Duration(seconds: 5));

  await tester.tap(find.text('Close'));
  await tester.pumpAndSettle(const Duration(seconds: 5));

  // Add to Shelf Book Two
  // await tester.tap(find.byKey(SeeMoreBookTwo));
  // await tester.pumpAndSettle(const Duration(seconds: 3));

  // expect(find.text(TEST_DATA_BOOK_NAME_TWO), findsWidgets);
  // expect(find.text(TEST_DATA_BOOK_AUTHOR_TWO), findsWidgets);
  // expect(find.text('Download'), findsOneWidget);
  // expect(find.text('Delete from your library'), findsOneWidget);
  // expect(find.text('Add to Shelf'), findsOneWidget);
  // expect(find.text('Make as read'), findsOneWidget);
  // expect(find.text('About this book'), findsOneWidget);

  // await tester.tap(find.text('Add to Shelf'));
  // await tester.pumpAndSettle(const Duration(seconds: 3));

  // expect(find.text(CreateShelfName), findsOneWidget);
  // expect(find.text(OneBookText), findsOneWidget);
  // await tester.tap(find.byType(Checkbox));
  // await tester.pumpAndSettle(const Duration(seconds: 3));

  // expect(find.byKey(KeyBookNameTwo), findsOneWidget);
  // expect(find.text(TwoBookText), findsOneWidget);

  // await tester.tap(find.byIcon(Icons.clear));
  // await tester.pumpAndSettle(const Duration(seconds: 5));

  // await tester.tap(find.text('Close'));
  // await tester.pumpAndSettle(const Duration(seconds: 5));

  // Add to Shelf Book Three
  // await tester.tap(find.byKey(SeeMoreBookThree));
  // await tester.pumpAndSettle(const Duration(seconds: 3));

  // expect(find.text(TEST_DATA_BOOK_NAME_THREE), findsWidgets);
  // expect(find.text(TEST_DATA_BOOK_AUTHOR_THREE), findsWidgets);
  // expect(find.text('Download'), findsOneWidget);
  // expect(find.text('Delete from your library'), findsOneWidget);
  // expect(find.text('Add to Shelf'), findsOneWidget);
  // expect(find.text('Make as read'), findsOneWidget);
  // expect(find.text('About this book'), findsOneWidget);

  // await tester.tap(find.text('Add to Shelf'));
  // await tester.pumpAndSettle(const Duration(seconds: 3));

  // expect(find.text(CreateShelfName), findsOneWidget);
  // expect(find.text(TwoBookText), findsOneWidget);
  // await tester.tap(find.byType(Checkbox));
  // await tester.pumpAndSettle(const Duration(seconds: 3));

  // expect(find.byKey(KeyBookNameThree), findsOneWidget);
  // expect(find.text(ThreeBookText), findsOneWidget);

  // await tester.tap(find.byIcon(Icons.clear));
  // await tester.pumpAndSettle(const Duration(seconds: 5));

  // await tester.tap(find.text('Close'));
  // await tester.pumpAndSettle(const Duration(seconds: 5));

  await tester.tap(find.byKey(KeyYourShelvesTab));
  await tester.pumpAndSettle(const Duration(seconds: 5));

  expect(find.text(CreateShelfName), findsOneWidget);
  expect(find.text(ThreeBookText), findsOneWidget);

  await tester.tap(find.byIcon(Icons.arrow_forward_ios));
  await tester.pumpAndSettle(const Duration(seconds: 5));

  expect(find.text(CreateShelfName), findsOneWidget);
  expect(find.text(ThreeBookText), findsOneWidget);

  await libraryPageTest(tester);

  await tester.tap(find.byKey(KeyViewMoreIcon));
  await tester.pumpAndSettle(const Duration(seconds: 5));

  await tester.tap(find.text('Rename shelf'));
  await tester.pumpAndSettle(const Duration(seconds: 5));

  expect(find.byType(TextFormField), findsOneWidget);
  await tester.enterText(find.byType(TextFormField), RenameShelfText);
  await tester.pumpAndSettle(const Duration(seconds: 5));
  await tester.testTextInput.receiveAction(TextInputAction.done);
  await tester.pumpAndSettle(const Duration(seconds: 3));

  expect(find.text(RenameShelfText), findsOneWidget);
  await tester.pumpAndSettle(const Duration(seconds: 2));

  await tester.tap(find.byKey(KeyViewMoreIcon));
  await tester.pumpAndSettle(const Duration(seconds: 5));

  await tester.tap(find.text('Delete shelf'));
  await tester.pumpAndSettle(const Duration(seconds: 5));

  expect(find.text('No shelf'), findsOneWidget);
  await tester.pumpAndSettle(const Duration(seconds: 3));
}
