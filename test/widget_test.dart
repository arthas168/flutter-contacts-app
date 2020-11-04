import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:contacts_app/main.dart';

void main() {
  testWidgets('GIVEN the contacts screen THEN the search bar should be visible on screen', (WidgetTester tester) async {

    await tester.pumpWidget(ContactsApp());

    expect(find.text('Search'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.search));
    await tester.pump();
  });

  testWidgets(
      'GIVEN an input with invalid characters THEN the flatten function will extract only the valid number',
          (WidgetTester tester) async {

      });

  testWidgets(
      'GIVEN a partial match for more than one number THEN all matching contacts are returned',
          (WidgetTester tester) async {




      });

}
