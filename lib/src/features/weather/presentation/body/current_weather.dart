import 'package:flutter/material.dart';
import 'package:life_weather_mobile/src/features/weather/presentation/widgets/weather_icon_image.dart';
import 'package:weather/weather.dart';

class CurrentWeather extends StatelessWidget {
  const CurrentWeather({Key? key, required this.currentWeather})
      : super(key: key);

  final Weather currentWeather;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('${currentWeather.areaName} ${currentWeather.country}',
            style: Theme.of(context).textTheme.headlineMedium),
        CurrentWeatherContents(data: currentWeather)
      ],
    );
  }
}

class CurrentWeatherContents extends StatelessWidget {
  const CurrentWeatherContents({Key? key, required this.data})
      : super(key: key);
  final Weather data;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final temp = data.temperature?.celsius?.toInt().toString();
    final minTemp = data.tempMin?.celsius?.toInt().toString();
    final maxTemp = data.tempMax?.celsius?.toInt().toString();
    final highAndLow = 'H:$maxTemp° L:$minTemp°';

    String iconUrl =
        "https://openweathermap.org/img/wn/${data.weatherIcon}@4x.png";

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        WeatherIconImage(iconUrl: iconUrl, size: 120),
        Text(temp ?? '', style: textTheme.displayMedium),
        Text(highAndLow, style: textTheme.bodyMedium),
      ],
    );
  }
}
