import 'package:flutter/material.dart';

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
        home: const ContactsListPage());
  }
}

class ContactsListPage extends StatefulWidget {
  const ContactsListPage({Key? key}) : super(key: key);

  @override
  State<ContactsListPage> createState() => _ContactsListPageState();
}

class _ContactsListPageState extends State<ContactsListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts App'),
      ),
      body: Center(
        child: Column(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
