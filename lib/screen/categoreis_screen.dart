import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sorting_task/model/contact_data_model.dart';
import 'package:sorting_task/widget/contact_item.dart';

// ignore: must_be_immutable
class CategoriesScreen extends StatelessWidget {
  List<Contact> data;
  CategoriesScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: listItem(context, data),
      ),
    );
  }
}
