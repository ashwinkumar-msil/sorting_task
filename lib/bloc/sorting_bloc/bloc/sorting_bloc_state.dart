part of 'sorting_bloc_bloc.dart';

@immutable
abstract class SortingBlocState {}

class SortingBlocInitial extends SortingBlocState {}

// ignore: must_be_immutable
class SortingTypeButtonClickState extends SortingBlocState {
  String btnText;
  SortingTypeButtonClickState(this.btnText);
}
