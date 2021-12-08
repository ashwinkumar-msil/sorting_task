import 'package:equatable/equatable.dart';
import 'package:sorting_task/model/contact_data_model.dart';
import 'package:sorting_task/service/contactrespo.dart';

import 'watchlist_event.dart';
import 'package:bloc/bloc.dart';

part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  ContactService contactRepo = ContactService();
  late List<Contact> data;

  WatchlistBloc() : super(WatchlistInitial()) {
    on<WatchlistEvent>((event, emit) async {
      if (event is FetchContactData) {
        emit(Contactblocloading());
        try {
          data = await contactRepo.fetchContact();

          emit(ContactFetchData(contacts: data));
        } catch (exception) {
          emit(ContactError(msg: exception.toString()));
        }
      } else if (event is TabChanged) {
        emit(Contactblocloading());

        List<Contact> contact =
            event.contactList.sublist(event.index * 25, (event.index + 1) * 25);
        emit(ContactTabData(contacts: contact));
      }

      if (event is SortContactEvent) {
        emit(Contactblocloading());

        emit(ContactTabData(
            contacts: event.listContacts, sortingType: event.sortingStr));
      }
    });
  }
}
