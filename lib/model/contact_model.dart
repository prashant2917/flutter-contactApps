import 'package:contacts_app/network/resource.dart';
import 'package:contacts_app/network/api_constants.dart';
import 'dart:convert';

class ContactModel {
  String? _status = null;

  int _count = 0;

  List<Contact> _contactList = List.empty(growable: true);

  static Resource<List<Contact>> get all {
    return Resource(
        url: getContactsUrl,
        parse: (response) {
          final result = json.decode(response.body);

          Iterable list = result['contacts'];

          if (list.isEmpty) {
            return List.empty();
          } else {
            return list.map((model) => Contact.fromJson(model)).toList();
          }
        });
  }
}

class Contact {
  int id = 0;

  String firstName = "";

  String middleName = "";

  String lastName = "";

  String address = "";

  String mobileNo = "";

  String emailId = "";

  String profileImageUrl = "";

  Contact.empty() {
    id = 0;
    firstName = "";
    middleName = "";
    lastName = "";
    address = "";
    mobileNo = "";
    emailId = "";
    profileImageUrl = "";
  }

  Contact(
      {required this.id,
      required this.firstName,
      required this.middleName,
      required this.lastName,
      required this.address,
      required this.mobileNo,
      required this.emailId,
      required this.profileImageUrl});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
        id: json['id'],
        firstName: json['first_name'],
        middleName: json['middle_name'],
        lastName: json['last_name'],
        address: json['address'],
        mobileNo: json['mobile_no'].toString(),
        emailId: json['email_id'],
        profileImageUrl: json['profile_image'] ?? placeholderImageAssetUrl);
  }
  @override
  String toString() {
    // TODO: implement toString
    return '${firstName + middleName + lastName + emailId + mobileNo + address} ';
  }
}
