import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_weather_mobile/src/core/bloc/profile/profile_bloc.dart';
import 'package:life_weather_mobile/src/core/utils/profile_utils.dart';
import 'package:life_weather_mobile/src/features/account/profile/data/repositories/profile_repository_impl.dart';
import 'package:life_weather_mobile/src/features/home/presentation/bloc/bloc/bottom_navigation_bloc.dart';
import 'package:life_weather_mobile/src/features/home/presentation/body/home_bottom_navbar.dart';
import 'package:life_weather_mobile/src/features/home/presentation/screens/home_screen.dart';
import 'package:life_weather_mobile/src/features/home/presentation/widgets/mood_tracker_dialog.dart';
import 'package:life_weather_mobile/src/features/journal/presentation/journal_screen.dart';
import 'package:life_weather_mobile/src/features/notifications/presentation/screen/notification_screen.dart';
import 'package:life_weather_mobile/src/features/weather/presentation/weather_screen_v2.dart';

class HomeNavigation extends StatefulWidget {
  const HomeNavigation({super.key});

  static const routeName = 'home-navigation/';

  @override
  State<HomeNavigation> createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation> {
  String? preSelect;

  static const List<Widget> _pages = <Widget>[
    HomeScreen(),
    WeatherScreenV2(),
    JournalScreen(),
    NotificationSccreen(),
    NotificationSccreen(),
  ];

  @override
  void initState() {
    handleEmoji();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: _pages.elementAt(state.index),
            ),
            bottomNavigationBar: HomeBottomNavBar(
              currentIndex: state.index,
              onTap: (int index) {
                handleUpdateBottomNav(index);
              },
            ),
          );
        },
      ),
    );
  }

  void handleEmoji() {
    final profile = ProfileUtils.userProfile(context);

    if (profile != null && profile.moodEmoji == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => moodTrackerDialog(
            context: context,
            preSelect: preSelect,
            onSelect: (value) {
              handleOnSelectEmoji(value);
            },
          ));
    }
  }

  void handleOnSelectEmoji(String value) {
    BlocProvider.of<ProfileBloc>(context).add(SetMoodEmoji(value));
    handleUpdateEmoji(value);
  }

  Future<void> handleUpdateEmoji(String value) async {
    await ProfileRepositoryImpl().updateMoodEmoji(value);
  }

  void handleUpdateBottomNav(int index) {
    BlocProvider.of<BottomNavigationBloc>(context)
        .add(UpdateBottomNavEvent(index));
  }
}
