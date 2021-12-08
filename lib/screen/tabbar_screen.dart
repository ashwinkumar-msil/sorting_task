import 'package:flutter/material.dart';
import 'package:sorting_task/model/contact_data_model.dart';

// ignore: must_be_immutable
class ContactsTabbarController extends StatelessWidget {
  ContactsTabbarController({Key? key, required this.contactList})
      : super(key: key);
  List<Contact> contactList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: contactList.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: ListTile(
              title: Text(contactList[index].name),
              subtitle: Text(contactList[index].contacts),
              trailing: Image.network('https://picsum.photos/200'),
            ),
          );
        });
  }
}
