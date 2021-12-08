// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sorting_task/bloc/sorting_bloc/bloc/sorting_bloc_bloc.dart';
import 'package:sorting_task/model/contact_data_model.dart';
import 'package:sorting_task/src/string.dart';

class SortingSheet extends StatelessWidget {
  SortingSheet(
      {Key? key, required this.contactList, required this.selectedSortedType})
      : super(key: key);
  String selectedSortedType;

  List<Contact> contactList;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SortingBlocBloc, SortingBlocState>(
      builder: (context, state) {
        if (state is SortingTypeButtonClickState) {
          selectedSortedType = state.btnText;
        }
        return Column(
          children: [
            Expanded(
                child: ListTile(
              leading: const Text(
                Strings.sorting,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              trailing: TextButton(
                child: const Text(
                  Strings.done,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                onPressed: () {
                  // ignore: unnecessary_null_comparison
                  if (selectedSortedType == null) {
                  } else {
                    BlocProvider.of<SortingBlocBloc>(context).add(
                        SortingDoneBtnActionEvent(
                            btnText: selectedSortedType,
                            contactList: contactList));
                    Navigator.pop(context);
                  }
                },
              ),
            )),
            Expanded(
              child: displayRow(
                  Strings.alphabetically,
                  Strings.alphabetAscending,
                  Strings.alphabetDecending,
                  state,
                  context),
            ),
            Divider(
              height: 2,
              color: Theme.of(context).dividerColor,
              indent: 15,
              endIndent: 15,
            ),
            Expanded(
              child: displayRow(Strings.userID, Strings.numericAscending,
                  Strings.numericDecending, state, context),
            ),
          ],
        );
      },
    );
  }

  Widget displayRow(String title, String sortingType1, String sortingType2,
      SortingBlocState state, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
            ),
          ),
          configureTextBtn(sortingType1, state, context),
          configureTextBtn(sortingType2, state, context)
        ],
      ),
    );
  }

  TextButton configureTextBtn(
      String text, SortingBlocState state, BuildContext context) {
    return TextButton(
      child: Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 18,
            color: (text == selectedSortedType)
                ? Theme.of(context).textSelectionTheme.selectionColor
                : Theme.of(context).textTheme.bodyText1?.color),
      ),
      onPressed: () {
        BlocProvider.of<SortingBlocBloc>(context)
            .add(SortingTypeButtonClickEvent(text));
      },
    );
  }
}
