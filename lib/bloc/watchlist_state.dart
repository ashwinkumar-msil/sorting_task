part of 'watchlist_bloc.dart';

abstract class WatchlistState extends Equatable {
  const WatchlistState();
  @override
  List<Contact> get props => [];
}

class WatchlistInitial extends WatchlistState {}

class ContactblocInitial extends WatchlistState {}

class Contactblocloading extends WatchlistState {}

// ignore: must_be_immutable
class ContactFetchData extends WatchlistState {
  List<Contact> contacts;
  ContactFetchData({required this.contacts});
}

// ignore: must_be_immutable
class ContactTabData extends WatchlistState {
  List<Contact> contacts;
  String? sortingType;
  ContactTabData({required this.contacts, this.sortingType});
}

// ignore: must_be_immutable
class ContactError extends WatchlistState {
  String msg;
  ContactError({required this.msg});
}
