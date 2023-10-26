import 'package:flutter/material.dart';
import 'package:life_weather_mobile/gen/colors.gen.dart';

class HomeBottomNavBar extends StatelessWidget {
  const HomeBottomNavBar(
      {super.key, required this.onTap, required this.currentIndex});

  final Function(int index) onTap;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: BottomNavigationBar(
        onTap: (value) {
          onTap(value);
        },
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        elevation: 1,
        enableFeedback: true,
        backgroundColor: ColorName.white, // <-- This works for fixed
        selectedItemColor: ColorName.primary,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: 'Todo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud_circle_sharp),
            label: 'Weather',
            backgroundColor: Colors.blue, // <-- This works for shifting
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pending_actions),
            label: 'Diary',
          ),
        ],
      ),
    );
  }
}
