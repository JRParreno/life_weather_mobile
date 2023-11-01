import 'package:flutter/material.dart';

import 'package:life_weather_mobile/src/core/widgets/common_widget.dart';
import 'package:life_weather_mobile/src/features/weather/presentation/widgets/weather_date.dart';
import 'package:life_weather_mobile/src/features/weather/presentation/widgets/weather_icon_image.dart';

class WeatherCelsiusCloud extends StatelessWidget {
  const WeatherCelsiusCloud({
    Key? key,
    required this.temperature,
    required this.tempFeelsLike,
    required this.icon,
    required this.date,
    required this.textColor,
  }) : super(key: key);

  final String temperature;
  final String tempFeelsLike;
  final String icon;
  final DateTime date;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    String iconUrl = "https://openweathermap.org/img/wn/$icon@4x.png";
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: SizedBox(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WeatherDate(
                  date: date,
                  textColor: textColor,
                ),
                CustomText(
                  text: '$temperature°',
                  style: TextStyle(
                    fontSize: 90,
                    color: textColor,
                  ),
                ),
                CustomText(
                  text: 'Feels like $tempFeelsLike°',
                  style: textTheme.bodyMedium!.apply(
                    fontWeightDelta: 4,
                    color: textColor.withOpacity(0.75),
                  ),
                ),
              ],
            ),
          ),
        ),
        WeatherIconImage(
          iconUrl: iconUrl,
          size: 150,
        )
      ],
    );
  }
}
