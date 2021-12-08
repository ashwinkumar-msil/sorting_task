import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sorting_task/bloc/watchlist_bloc.dart';
import 'package:sorting_task/screen/tab_bar.dart';
import 'package:sorting_task/src/string.dart';
import 'bloc/theme/theme_bloc.dart';
import 'data/apptheme.dart';

void main() => runApp(const HomePage());

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeMode>(
        builder: (context, state) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: Strings.appTitle,
              theme: MyTheme.lightTheme,
              darkTheme: MyTheme.dartkTheme,
              themeMode: state,
              home: BlocProvider(
                create: (context) => WatchlistBloc(),
                child: const TabBarScreen(),
              ));
        },
      ),
    );
  }
}
