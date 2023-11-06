import 'package:flutter/material.dart';
import 'package:life_weather_mobile/src/core/widgets/common_widget.dart';

class NotificationSccreen extends StatefulWidget {
  const NotificationSccreen({super.key});

  static const String routeName = 'notification/';

  @override
  State<NotificationSccreen> createState() => _NotificationSccreenState();
}

class _NotificationSccreenState extends State<NotificationSccreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CustomText(text: 'Working in progress'),
    );
  }
}
