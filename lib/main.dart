import 'package:contacts_app/add_contact.dart';
import 'package:contacts_app/model/contact_model.dart';
import 'package:contacts_app/network/resource.dart';
import 'package:flutter/material.dart';
import 'package:contacts_app/network/api_constants.dart';

void main() {
  runApp(const ContactsApp());
}

class ContactsApp extends StatelessWidget {

  const ContactsApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Contacts App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {

          '/': (context) => const ContactsListPage(),

          '/addContact': (context) => AddContactPage(contact: Contact.empty()),
        },
        //home: const ContactsListPage());
    );
  }
}

class ContactsListPage extends StatefulWidget {
  const ContactsListPage({Key? key}) : super(key: key);

  @override
  State<ContactsListPage> createState() => _ContactsListPageState();
}

class _ContactsListPageState extends State<ContactsListPage> {
  List<Contact> _contactList = List.empty(growable: true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getContacts();
  }

  void _getContacts() {
    Webservice().load(ContactModel.all).then((contacts) => {
          setState(() => {_contactList = contacts})
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts List'),
      ),
      body: ListView.builder(
          itemCount: _contactList.length, itemBuilder: _listViewItemBuilder),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          Navigator.pushNamed(context, '/addContact');
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _listViewItemBuilder(BuildContext context, int index) {
    var contact = _contactList[index];

    return Container(
        padding: const EdgeInsets.all(10.0),
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Colors.white,
            elevation: 10,
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              ListTile(
                onTap: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddContactPage(contact: _contactList[index])),
                  );
                },
                leading: loadImage(contact.profileImageUrl),
                title: Text(
                    contact.firstName +
                        ' ' +
                        contact.middleName +
                        ' ' +
                        contact.lastName,
                    style: const TextStyle(fontSize: 18)),
                subtitle: Text(contact.address + "," + contact.mobileNo,
                    style: const TextStyle(fontSize: 18)),
              )
            ])));
  }

  Widget loadImage(String profileImageUrl) {
    if (profileImageUrl == '') {
      return Container(
          width: 70.0,
          height: 70.0,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(placeholderImageAssetUrl))));
    } else {
      return Container(
          width: 70.0,
          height: 70.0,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(profilePicUrl + profileImageUrl))));
    }
  }
}
