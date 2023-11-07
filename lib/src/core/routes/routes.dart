import 'package:flutter/material.dart';
import 'package:life_weather_mobile/src/features/account/forgot_password/presentation/screen/forgot_password_screen.dart';
import 'package:life_weather_mobile/src/features/account/login/presentation/screen/login_screen.dart';
import 'package:life_weather_mobile/src/features/account/signup/presentation/screens/sign_up_screen.dart';
import 'package:life_weather_mobile/src/features/home/presentation/screens/home_navigation.dart';
import 'package:life_weather_mobile/src/features/home/presentation/screens/home_screen.dart';
import 'package:life_weather_mobile/src/features/journal/diary/presentation/screen/diary_add_screen.dart';
import 'package:life_weather_mobile/src/features/journal/diary/presentation/screen/diary_detail_screen.dart';
import 'package:life_weather_mobile/src/features/journal/diary/presentation/screen/diary_lapse_add_update_screen.dart';
import 'package:life_weather_mobile/src/features/journal/diary/presentation/screen/diary_screen.dart';
import 'package:life_weather_mobile/src/features/journal/presentation/journal_screen.dart';
import 'package:life_weather_mobile/src/features/journal/todo/presentation/screens/todo_add_update_screen.dart';
import 'package:life_weather_mobile/src/features/journal/todo/presentation/screens/todo_screen.dart';
import 'package:life_weather_mobile/src/features/notifications/presentation/screen/notification_screen.dart';
import 'package:life_weather_mobile/src/features/weather/presentation/weather_screen.dart';
import 'package:life_weather_mobile/src/features/weather/presentation/weather_screen_v2.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  return MaterialPageRoute(
    settings: settings,
    builder: (context) {
      switch (settings.name) {
        case LoginScreen.routeName:
          return const LoginScreen();
        case SignUpScreen.routeName:
          return const SignUpScreen();
        case ForgotPasswordScreen.routeName:
          return const ForgotPasswordScreen();
        case HomeNavigation.routeName:
          return const HomeNavigation();
        case HomeScreen.routeName:
          return const HomeScreen();
        case JournalScreen.routeName:
          return const JournalScreen();
        case TodoScreen.routeName:
          return const TodoScreen();
        case TodoAddUpdateScreen.routeName:
          final args = settings.arguments! as TodoAddUpdateArgs;
          return TodoAddUpdateScreen(
            args: args,
          );
        case WeatherScreen.routeName:
          return const WeatherScreen();
        case WeatherScreenV2.routeName:
          return const WeatherScreenV2();
        case NotificationSccreen.routeName:
          return const NotificationSccreen();

        // Diary
        case DiaryAddScreen.routeName:
          return const DiaryAddScreen();
        case DiaryScreen.routeName:
          return const DiaryScreen();
        case DiaryLapseAddUpdateScreen.routeName:
          final args = settings.arguments! as DiaryLapseAddUpdateArgs;
          return DiaryLapseAddUpdateScreen(
            args: args,
          );
        case DiaryDetailScreen.routeName:
          final args = settings.arguments! as DiaryDetailArgs;
          return DiaryDetailScreen(
            args: args,
          );
      }

      return const Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Text('Something went wrong'),
        ),
      );
    },
  );
}
