import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:contacts_app/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {

    await tester.pumpWidget(ContactsApp());

    expect(find.text('Search'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.search));
    await tester.pump();
  });
}
