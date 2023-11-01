import 'package:flutter/material.dart';
import 'package:life_weather_mobile/src/core/widgets/common_widget.dart';
import 'package:life_weather_mobile/src/features/weather/presentation/widgets/weather_date.dart';
import 'package:life_weather_mobile/src/features/weather/presentation/widgets/weather_icon_image.dart';
import 'package:weather/weather.dart';

class FiveDaysWeather extends StatelessWidget {
  const FiveDaysWeather({
    super.key,
    required this.weather,
  });

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    String iconUrl =
        "https://openweathermap.org/img/wn/${weather.weatherIcon}@4x.png";

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFA1C3EA),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 15,
          )
        ],
      ),
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          WeatherIconImage(iconUrl: iconUrl, size: 100),
          CustomText(
            text: '${weather.temperature?.celsius?.toInt().toString()}° C',
            style: const TextStyle(
              fontSize: 40,
              color: Colors.black54,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          WeatherDate(
            date: weather.date!,
            textColor: Colors.black54,
            axis: Axis.vertical,
          )
        ],
      ),
    );
  }
}
