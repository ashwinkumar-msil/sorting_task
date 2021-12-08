import 'package:sorting_task/model/contact_data_model.dart';

abstract class WatchlistEvent {}

class FetchContactData extends WatchlistEvent {}

class TabChanged extends WatchlistEvent {
  int index;
  List<Contact> contactList;
  TabChanged({required this.index, required this.contactList});
}

class FetchContactData1 extends WatchlistEvent {}

class FetchContactData2 extends WatchlistEvent {}

class FetchContactData3 extends WatchlistEvent {}

class SortContactEvent extends WatchlistEvent {
  List<Contact> listContacts;
  String sortingStr;
  SortContactEvent({required this.listContacts, required this.sortingStr});
}

class FetchContactData4 extends WatchlistEvent {}
