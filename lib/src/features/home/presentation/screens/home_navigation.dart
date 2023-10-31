import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_weather_mobile/src/core/bloc/profile/profile_bloc.dart';
import 'package:life_weather_mobile/src/features/account/profile/data/repositories/profile_repository_impl.dart';
import 'package:life_weather_mobile/src/features/home/presentation/body/home_bottom_navbar.dart';
import 'package:life_weather_mobile/src/features/home/presentation/screens/home_screen.dart';
import 'package:life_weather_mobile/src/features/journal/presentation/journal_screen.dart';

class HomeNavigation extends StatefulWidget {
  const HomeNavigation({super.key});

  static const routeName = 'home-navigation/';

  @override
  State<HomeNavigation> createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation> {
  int currentElement = 0;
  String? preSelect;

  static const List<Widget> _pages = <Widget>[
    HomeScreen(),
    HomeScreen(),
    JournalScreen(),
    HomeScreen(),
    HomeScreen(),
  ];

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((_) => moodTrackerDialog(
    //       context: context,
    //       preSelect: preSelect,
    //       onSelect: (value) {
    //         handleOnSelectEmoji(value);
    //       },
    //     ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: SafeArea(
          child: _pages.elementAt(currentElement),
        ),
        bottomNavigationBar: HomeBottomNavBar(
          currentIndex: currentElement,
          onTap: (int index) {
            setState(() {
              currentElement = index;
            });
          },
        ),
      ),
    );
  }

  void handleOnSelectEmoji(String value) {
    BlocProvider.of<ProfileBloc>(context).add(SetMoodEmoji(value));
    handleUpdateEmoji(value);
  }

  Future<void> handleUpdateEmoji(String value) async {
    await ProfileRepositoryImpl().updateMoodEmoji(value);
  }
}
