import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:life_weather_mobile/src/core/utils/spacing/v_space.dart';
import 'package:life_weather_mobile/src/core/widgets/common_widget.dart';
import 'package:life_weather_mobile/src/features/weather/presentation/widgets/weather_celcius_cloud.dart';
import 'package:life_weather_mobile/src/features/weather/presentation/widgets/weather_location.dart';
import 'package:life_weather_mobile/src/features/weather/presentation/widgets/weather_other.dart';
import 'package:life_weather_mobile/src/features/weather/presentation/widgets/weather_temp.dart';
import 'package:weather/weather.dart';

class ColorModel {
  final Color backgroundColor;
  final Color textColor;

  ColorModel({
    required this.backgroundColor,
    required this.textColor,
  });
}

class CurrentWeatherV2 extends StatelessWidget {
  const CurrentWeatherV2({
    Key? key,
    required this.weather,
  }) : super(key: key);

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    final weatherConditionColor =
        getBGWeatherCondition(weather.weatherConditionCode ?? 0);

    final textTheme = Theme.of(context).textTheme;
    final height = MediaQuery.of(context).size.height;

    return Container(
      height: height * 0.36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: weatherConditionColor.backgroundColor,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 25,
          )
        ],
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          WeatherCelsiusCloud(
            date: weather.date!,
            temperature: weather.temperature?.celsius?.toInt().toString() ?? '',
            tempFeelsLike:
                weather.tempFeelsLike?.celsius?.toInt().toString() ?? '',
            icon: weather.weatherIcon ?? '',
            textColor: weatherConditionColor.textColor,
          ),
          Vspace.sm,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text:
                        '${toBeginningOfSentenceCase(weather.weatherDescription)}',
                    style: textTheme.headlineSmall!.apply(
                      color: weatherConditionColor.textColor,
                    ),
                  ),
                  Vspace.sm,
                  WeatherTemperature(
                    lowTemp: '${weather.tempMin?.celsius?.toInt().toString()}°',
                    highTemp:
                        '${weather.tempMax?.celsius?.toInt().toString()}°',
                    textColor: weatherConditionColor.textColor,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  WeatherLocation(
                    areaName: weather.areaName ?? '',
                    country: weather.country ?? '',
                    textColor: weatherConditionColor.textColor,
                  ),
                  Vspace.sm,
                  WeatherOther(
                    humidity: weather.humidity ?? 0,
                    windSpeed: weather.windSpeed ?? 0,
                    textColor: weatherConditionColor.textColor,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  ColorModel getBGWeatherCondition(int id) {
    /**
     * 
     * check the official openweathermap id
     * https://openweathermap.org/weather-conditions
     * 
     */

    if (id >= 200 && id <= 232) {
      // Thunderstorm
      return ColorModel(
        backgroundColor: const Color(0xFF2D3656),
        textColor: Colors.white,
      );
    } else if (id >= 300 && id <= 321) {
      // Drizle
      return ColorModel(
        backgroundColor: const Color(0xFF91B2B1),
        textColor: Colors.black,
      );
    } else if (id >= 500 && id <= 531) {
      // Rain
      return ColorModel(
        backgroundColor: const Color(0xFF0976F5),
        textColor: Colors.white,
      );
    } else if (id >= 600 && id <= 622) {
      // Snow
      return ColorModel(
        backgroundColor: const Color(0xFF5C72D1),
        textColor: Colors.white,
      );
    } else if (id >= 701 && id <= 781) {
      // Atmoshphere
      return ColorModel(
        backgroundColor: const Color(0xFFF77B57),
        textColor: Colors.white,
      );
    } else if (id >= 801 && id <= 804) {
      // Clouds
      return ColorModel(
        backgroundColor: const Color(0xFFDED7D3),
        textColor: Colors.black,
      );
    } else {
      // Clear Sky
      return ColorModel(
        backgroundColor: const Color(0xFFFFFFFF),
        textColor: Colors.black,
      );
    }
  }
}
