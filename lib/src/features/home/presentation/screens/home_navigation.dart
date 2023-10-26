import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:life_weather_mobile/src/features/home/presentation/body/home_bottom_navbar.dart';
import 'package:life_weather_mobile/src/features/home/presentation/screens/home_screen.dart';

class HomeNavigation extends StatefulWidget {
  const HomeNavigation({super.key});

  static const routeName = 'home-navigation/';

  @override
  State<HomeNavigation> createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation> {
  int currentElement = 0;

  static const List<Widget> _pages = <Widget>[
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
  ];

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
}
