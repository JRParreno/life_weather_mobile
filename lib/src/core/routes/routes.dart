import 'package:flutter/material.dart';
import 'package:life_weather_mobile/src/features/account/forgot_password/presentation/screen/forgot_password_screen.dart';
import 'package:life_weather_mobile/src/features/account/login/presentation/screen/login_screen.dart';
import 'package:life_weather_mobile/src/features/account/signup/presentation/screens/sign_up_screen.dart';

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
