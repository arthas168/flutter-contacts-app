import 'package:contacts_app/main.dart';
import 'package:contacts_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class Email {
  String value;

  Email(this.value);
}

class Phone {
  String value;

  Phone(this.value);
}

class SampleContact {
  String displayName;
  List<Phone> phones;
  List<Email> emails;

  SampleContact(this.displayName, this.phones, this.emails);
}

void main() {
  testWidgets(
      'GIVEN the contacts screen THEN the search bar should be visible on screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(ContactsApp());

    expect(find.text('Search'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.search));
    await tester.pump();
  });

  testWidgets(
      'GIVEN an input with invalid characters THEN the flatten function will extract only the valid number',
      (WidgetTester tester) async {
    var validPhoneNumber = flattenPhoneNumber("+359__89-67-6 03-8  .9");
    expect(validPhoneNumber, "+359896760389");

    var validPartialNumber = flattenPhoneNumber("  234- 45");
    expect(validPartialNumber, "23445");
  });

  testWidgets(
      'GIVEN a partial or full match for a name, phone or email THEN the contact should be retained',
      (WidgetTester tester) async {
    SampleContact sampleContact1 = new SampleContact(
        "Bilbo Baggins", [Phone("0123440534")], [Email("bilbo@theshire.com")]);
    SampleContact sampleContact2 = new SampleContact(
        "Don Draper", [Phone("4423523645")], [Email("draper@madmen.com")]);
    SampleContact sampleContact3 = new SampleContact("Eddard Stark",
        [Phone("237686543")], [Email("ned@winteriscoming.net")]);

    expect(retainContact("bilbo", sampleContact1), true);
    expect(retainContact("bil", sampleContact1), true);
    expect(retainContact("il", sampleContact1), true);
    expect(retainContact("23523", sampleContact2), true);
    expect(retainContact("@madmen", sampleContact2), true);
    expect(retainContact("stark", sampleContact3), true);
    expect(retainContact("  23 7-6_86", sampleContact3), true);

    expect(retainContact("frodo", sampleContact1), false);
    expect(retainContact("@houseofcards", sampleContact2), false);
    expect(retainContact("00000", sampleContact3), false);
  });
}
