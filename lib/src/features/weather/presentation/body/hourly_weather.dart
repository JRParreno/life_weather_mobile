import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:life_weather_mobile/src/features/weather/presentation/widgets/weather_icon_image.dart';
import 'package:weather/weather.dart';

class HourlyWeather extends StatelessWidget {
  const HourlyWeather({super.key, required this.fwDays});

  final List<Weather> fwDays;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: fwDays.map((data) => HourlyWeatherItem(data: data)).toList());
  }
}

class HourlyWeatherItem extends StatelessWidget {
  const HourlyWeatherItem({Key? key, required this.data}) : super(key: key);
  final Weather data;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    const fontWeight = FontWeight.normal;
    final temp = data.temperature?.celsius?.toInt().toString();
    String iconUrl =
        "https://openweathermap.org/img/wn/${data.weatherIcon}@4x.png";

    return Expanded(
      child: Column(
        children: [
          Text(
            DateFormat.E().format(data.date!),
            style: textTheme.bodySmall!.copyWith(fontWeight: fontWeight),
          ),
          const SizedBox(height: 8),
          WeatherIconImage(iconUrl: iconUrl, size: 48),
          const SizedBox(height: 8),
          Text(
            '$temp°',
            style: textTheme.bodyLarge!.copyWith(fontWeight: fontWeight),
          ),
        ],
      ),
    );
  }
}
