import 'dart:convert';

import 'package:contacts_app/model/response_model.dart';
import 'package:contacts_app/network/api_constants.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:contacts_app/model/contact_model.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;

import 'network/resource.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({Key? key, required this.contact}) : super(key: key);
  final Contact contact;

  @override
  State<StatefulWidget> createState() {
    return AddContactState(contact);
  }
}

class AddContactState extends State<AddContactPage> {
  late Contact _contact;
  String imageBase64 ='';

  AddContactState(Contact contact) {
    _contact = contact;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController firstNameController =
        TextEditingController(text: _contact.firstName);
    TextEditingController middleNameController =
        TextEditingController(text: _contact.middleName);
    TextEditingController lastNameController =
        TextEditingController(text: _contact.lastName);
    TextEditingController emailController =
        TextEditingController(text: _contact.emailId);
    TextEditingController mobileController =
        TextEditingController(text: _contact.mobileNo);
    TextEditingController addressController =
        TextEditingController(text: _contact.address);
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
        appBar: AppBar(
          title:
              Text(_contact.firstName == "" ? "Add Contact" : "Edit Contact"),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                loadImage(_contact.profileImageUrl),
                IconButton(
                  icon: const Icon(Icons.edit),
                  tooltip: 'Edit Image',
                  onPressed: () {
                    setState(() {});
                  },
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                            controller: firstNameController,
                            keyboardType: TextInputType.name,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                              hintText: 'First Name',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter First Name';
                              }
                              return null;
                            }),
                        TextFormField(
                            controller: middleNameController,
                            keyboardType: TextInputType.name,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                              hintText: 'Middle Name',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Middle Name';
                              }
                              return null;
                            }),
                        TextFormField(
                            controller: lastNameController,
                            keyboardType: TextInputType.name,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                              hintText: 'Last Name',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Last Name';
                              }
                              return null;
                            }),
                        TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                              hintText: 'Email',
                            ),
                            validator: (value) {
                              if (value == null ||
                                  !EmailValidator.validate(value)) {
                                return 'Please enter Valid Email';
                              }
                              return null;
                            }),
                        TextFormField(
                            controller: mobileController,
                            maxLength: 10,
                            keyboardType: TextInputType.phone,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                              hintText: 'Mobile Number',
                            ),
                            validator: (value) {
                              if (value == null || value.length < 10) {
                                return 'Please enter Valid Mobile Number';
                              }
                              return null;
                            }),
                        TextFormField(
                            controller: addressController,
                            maxLength: 500,
                            keyboardType: TextInputType.streetAddress,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                              hintText: 'Address',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter  Address';
                              }
                              return null;
                            }),
                      ],
                    )),
                SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: MaterialButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                       /* ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );*/
                      var params =   <String, dynamic>{
                          'first_name': firstNameController.text,
                          'middle_name': middleNameController.text,
                          'last_name': lastNameController.text,
                          'email_id': emailController.text,
                          'mobile_no': mobileController.text,
                          'address': addressController.text
                          //profile_image
                        };
                        if(_contact.id == 0) {
                          Webservice().post(ResponseModel.registerUser(), params).then((responseModel) => {
                          showSnackBar(responseModel.message.toString())
                          });
                        }

                        else {
                          print("contact id "+_contact.id.toString());
                          params =   <String, dynamic>{
                            'id' : _contact.id.toString(),
                            'first_name': firstNameController.text,
                            'middle_name': middleNameController.text,
                            'last_name': lastNameController.text,
                            'email_id': emailController.text,
                            'mobile_no': mobileController.text,
                            'address': addressController.text
                            //profile_image
                          };
                          Webservice().post(ResponseModel.updateUser(), params).then((responseModel) => {
                            showSnackBar(responseModel.message.toString())
                          });
                        }


                      }
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(fontSize: 15),
                    ),
                    textColor: Colors.white,
                    color: Colors.lightBlueAccent,
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget loadImage(String profileImageUrl) {
    if (profileImageUrl == '') {
      return Container(
          width: 120.0,
          height: 120.0,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(placeholderImageAssetUrl))));
    } else {
      networkImageToBase64(profilePicUrl + profileImageUrl);
      return Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(profilePicUrl + profileImageUrl))));
    }
  }

  networkImageToBase64(String imageUrl) async {
    http.Response response = await http.get(Uri.parse(imageUrl));
    imageBase64 = base64Encode(response.bodyBytes);
  }

  showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
