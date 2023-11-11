import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:life_weather_mobile/gen/colors.gen.dart';
import 'package:life_weather_mobile/src/core/utils/spacing/v_space.dart';
import 'package:life_weather_mobile/src/core/widgets/common_widget.dart';
import 'package:life_weather_mobile/src/features/notifications/data/models/notification.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.notificationModel,
  });

  final NotificationModel notificationModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: ColorName.white,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.all(7),
        title: CustomText(text: notificationModel.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Vspace.xxs,
            CustomText(
              text: notificationModel.subTitle,
              style: const TextStyle(
                color: ColorName.placeHolder,
              ),
            ),
            Vspace.xxs,
            CustomText(
              text: dateFormatted(
                notificationModel.dateCreated,
              ),
              style: const TextStyle(
                fontSize: 10,
                color: ColorName.placeHolder,
              ),
            )
          ],
        ),
        leading: const Icon(
          Icons.notifications_active,
          size: 30,
          color: ColorName.placeHolder,
        ),
        onTap: () {},
      ),
    );
  }

  String dateFormatted(String dateCreated) {
    final dateFormat = DateFormat.yMd().add_jm();
    return dateFormat.format(DateTime.parse(dateCreated));
  }
}
