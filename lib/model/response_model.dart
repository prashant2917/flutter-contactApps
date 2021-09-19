import 'package:contacts_app/model/contact_model.dart';
import 'package:contacts_app/network/resource.dart';
import 'package:contacts_app/network/api_constants.dart';
import 'dart:convert';

class ResponseModel {
  int status = -1;
  String? message;

  ResponseModel({required this.status, this.message});

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    print("json decode message : ${ json['message']}");
    return ResponseModel(
      status: json['status'],
      message: json['message'],
    );
  }

  static Resource<ResponseModel>  registerUser() {
    return Resource(
        url: registerUserUrl,
        parse: (response) {
          final result = json.decode(response.body);
          print("result is $result");

          return ResponseModel.fromJson(result);
        });
  }

  static Resource<ResponseModel>  updateUser() {
    return Resource(
        url: updateUserUrl,
        parse: (response) {
          final result = json.decode(response.body);
          print("result is $result");

          return ResponseModel.fromJson(result);
        });
  }
}
