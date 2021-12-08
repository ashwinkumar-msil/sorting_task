import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sorting_task/bloc/sorting_bloc/bloc/sorting_bloc_bloc.dart';
import 'package:sorting_task/bloc/theme/theme_bloc.dart';
import 'package:sorting_task/bloc/watchlist_bloc.dart';
import 'package:sorting_task/bloc/watchlist_event.dart';
import 'package:sorting_task/model/contact_data_model.dart';
import 'package:sorting_task/screen/sorting_sheet.dart';
import 'package:sorting_task/src/string.dart';
import 'package:sorting_task/widget/changethemebutton.dart';
import 'categoreis_screen.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({Key? key}) : super(key: key);

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late WatchlistBloc watchlistBloc;
  Map<int, String> sortingTypeAppliedAtTabIndex = {};
  ThemeBloc themeBloc = ThemeBloc();
  bool isLightTheme = false;
  List<Contact> contactdata = [];
  int userCurrentTab = 0;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 4);
    watchlistBloc = BlocProvider.of<WatchlistBloc>(context);
    watchlistBloc.add(FetchContactData());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    watchlistBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: Strings.name.length,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          actions: [
            const ThemeSelector(),
            IconButton(
                key: const ValueKey('sorting'),
                onPressed: () {
                  sortBtnAction(
                      context,
                      watchlistBloc,
                      contactdata.sublist(
                          userCurrentTab * 25, (userCurrentTab + 1) * 25),
                      sortingTypeAppliedAtTabIndex[userCurrentTab]);
                },
                icon: const Icon(Icons.sort_by_alpha))
          ],
          title: const Text(
            Strings.title,
          ),
          bottom: TabBar(
            controller: _tabController,
            indicatorWeight: 4.0,
            indicatorColor: Colors.blue,
            tabs: Strings.name,
            onTap: (index) => {
              userCurrentTab = index,
              watchlistBloc
                  .add(TabChanged(index: index, contactList: contactdata))
            },
          ),
        ),
        body: BlocBuilder<WatchlistBloc, WatchlistState>(
          builder: (context, state) {
            if (state is Contactblocloading) {
              return const Text(Strings.loading);
            } else if (state is ContactFetchData) {
              contactdata = state.contacts;
              if (contactdata == []) {
                return const Text(Strings.loading);
              } else {
                return CategoriesScreen(
                  data: contactdata.sublist(0, 25),
                );
              }
            } else if (state is ContactTabData) {
              if (state.sortingType != null) {
                sortingTypeAppliedAtTabIndex[userCurrentTab] =
                    state.sortingType!;
              }

              return CategoriesScreen(data: state.contacts);
            } else if (state is ContactError) {
              return const Text(Strings.unknownError);
            } else {
              return const Text(Strings.unknownError);
            }
          },
        ),
      ),
    );
  }

  void sortBtnAction(BuildContext context, WatchlistBloc watchlistBloc,
      List<Contact> conatctListAtParticularTab, String? sortingType) {
    showModalBottomSheet(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.22),
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) {
        return BlocProvider(
          create: (context) => SortingBlocBloc(watchlistBloc),
          child: SafeArea(
            child: SortingSheet(
              contactList: conatctListAtParticularTab,
              selectedSortedType: sortingType ?? "",
            ),
          ),
        );
      },
    );
  }
}
