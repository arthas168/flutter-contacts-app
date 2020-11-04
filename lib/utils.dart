import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';

TextEditingController searchController = new TextEditingController();

String flattenPhoneNumber(String phoneStr) {
  return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
    return m[0] == "+" ? "+" : "";
  });
}

filterContacts(contacts) {
  List<Contact> _contacts = [];
  _contacts.addAll(contacts);
  if (searchController.text.isNotEmpty) {
    _contacts.retainWhere((contact) {
      String searchTerm = searchController.text.toLowerCase();
      String searchTermFlatten = flattenPhoneNumber(searchTerm);
      String contactName = contact.displayName.toLowerCase();
      bool nameMatches = contactName.contains(searchTerm);
      if (nameMatches == true) {
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
    });
  }
  return _contacts;
}