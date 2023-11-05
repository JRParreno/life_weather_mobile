import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:life_weather_mobile/src/core/utils/spacing/v_space.dart';

import 'package:life_weather_mobile/src/core/widgets/common_widget.dart';

class WeatherTemperature extends StatelessWidget {
  final String lowTemp;
  final String highTemp;
  final Color textColor;
  const WeatherTemperature({
    Key? key,
    required this.lowTemp,
    required this.highTemp,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: 'Temp Max/Min',
          style: textTheme.bodyMedium!.apply(
            color: textColor,
          ),
        ),
        Vspace.xxs,
        Row(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.arrow_upward,
                  color: textColor,
                  size: 15,
                ),
                CustomText(
                  text: highTemp,
                  style: textTheme.bodyMedium!.apply(
                    color: textColor,
                  ),
                ),
              ],
            ),
            const Gap(10),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.arrow_downward,
                  color: textColor,
                  size: 15,
                ),
                CustomText(
                  text: lowTemp,
                  style: textTheme.bodyMedium!.apply(
                    color: textColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
