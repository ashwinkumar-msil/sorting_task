part of 'sorting_bloc_bloc.dart';

@immutable
abstract class SortingBlocEvent {}

// ignore: must_be_immutable
class SortingTypeButtonClickEvent extends SortingBlocEvent {
  String btnText;
  SortingTypeButtonClickEvent(this.btnText);
}

// ignore: must_be_immutable
class SortingDoneBtnActionEvent extends SortingBlocEvent {
  String btnText;
  List<Contact> contactList;
  SortingDoneBtnActionEvent({required this.btnText, required this.contactList});
}
