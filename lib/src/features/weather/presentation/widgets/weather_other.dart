import 'package:flutter/material.dart';
import 'package:life_weather_mobile/src/core/utils/spacing/v_space.dart';
import 'package:life_weather_mobile/src/core/widgets/common_widget.dart';

class WeatherOther extends StatelessWidget {
  const WeatherOther({
    super.key,
    required this.humidity,
    required this.windSpeed,
    required this.textColor,
  });

  final double humidity;
  final double windSpeed;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Icon(
              Icons.water_drop_outlined,
              color: textColor,
              size: 20,
            ),
            Vspace.xxs,
            CustomText(
              text: '${humidity.toInt()} %',
              style: textTheme.bodyMedium!.apply(
                color: textColor,
              ),
            )
          ],
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          children: [
            Icon(
              Icons.air_outlined,
              color: textColor,
              size: 20,
            ),
            Vspace.xxs,
            CustomText(
              text: '$windSpeed m/s',
              style: textTheme.bodyMedium!.apply(
                color: textColor,
              ),
            )
          ],
        )
      ],
    );
  }
}
