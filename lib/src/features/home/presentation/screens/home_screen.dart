import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:life_weather_mobile/gen/colors.gen.dart';
import 'package:life_weather_mobile/src/core/utils/profile_utils.dart';
import 'package:life_weather_mobile/src/core/utils/spacing/v_space.dart';
import 'package:life_weather_mobile/src/core/widgets/common_widget.dart';
import 'package:life_weather_mobile/src/features/home/presentation/body/home_bottom_navbar.dart';
import 'package:life_weather_mobile/src/features/home/presentation/body/home_header.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home/';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: ColorName.white,
          child: Column(
            children: [
              const HomeHeader(),
              Vspace.md,
              CustomBtn(
                label: 'Logout',
                onTap: () => handleLogout(context),
              )
            ],
          ),
        ),
      ),
    );
  }

  void handleLogout(BuildContext ctx) {
    ProfileUtils.handleLogout(ctx);
  }
}
