import 'package:flutter/cupertino.dart';

TextEditingController searchController = new TextEditingController();

String flattenPhoneNumber(String phoneStr) {
  return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
    return m[0] == "+" ? "+" : "";
  });
}

bool retainContact(searchTerm, contact) {
  String searchTermFlatten = flattenPhoneNumber(searchTerm);
  String contactName = contact.displayName.toLowerCase();
  String contactEmail = contact.emails.elementAt(0).value;

  bool nameMatches = contactName.contains(searchTerm);
  bool emailMatches = contactEmail.contains(searchTerm);

  if (nameMatches == true) {
    return true;
  }

  if (emailMatches == true) {
    return true;
  }

  if (searchTermFlatten.isEmpty) {
    return false;
  }

  var phone = contact.phones.firstWhere((phn) {
    String flattenedPhone = flattenPhoneNumber(phn.value);
    return flattenedPhone.contains(searchTermFlatten);
  }, orElse: () => null);

  return phone != null;
}
