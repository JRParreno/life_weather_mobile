import 'package:flutter/material.dart';
import 'package:life_weather_mobile/src/core/widgets/common_widget.dart';
import 'package:life_weather_mobile/src/features/notifications/data/models/notification.dart';
import 'package:life_weather_mobile/src/features/notifications/presentation/widgets/notification_card.dart';

class NotificationSccreen extends StatefulWidget {
  const NotificationSccreen({super.key});

  static const String routeName = 'notification/';

  @override
  State<NotificationSccreen> createState() => _NotificationSccreenState();
}

class _NotificationSccreenState extends State<NotificationSccreen> {
  final List<NotificationModel> notifications = [
    NotificationModel(
      title: 'Notification 1',
      subTitle: 'Notification Subtitle 1',
      dateCreated: DateTime.now().toLocal().toString(),
    ),
    NotificationModel(
      title: 'Notification 2',
      subTitle: 'Notification Subtitle 2',
      dateCreated: DateTime.now().toLocal().toString(),
    ),
    NotificationModel(
      title: 'Notification 3',
      subTitle: 'Notification Subtitle 3',
      dateCreated: DateTime.now().toLocal().toString(),
    ),
    NotificationModel(
      title: 'Notification 4',
      subTitle: 'Notification Subtitle 4',
      dateCreated: DateTime.now().toLocal().toString(),
    ),
    NotificationModel(
      title: 'Notification 5',
      subTitle: 'Notification Subtitle 5',
      dateCreated: DateTime.now().toLocal().toString(),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context: context,
        showBackBtn: true,
        title: 'Notifications',
        isDarkMode: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notification = notifications[index];
            return NotificationCard(notificationModel: notification);
          },
        ),
      ),
    );
  }
}
