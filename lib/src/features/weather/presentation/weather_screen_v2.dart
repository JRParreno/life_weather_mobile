import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_weather_mobile/gen/colors.gen.dart';
import 'package:life_weather_mobile/src/core/bloc/view_status.dart';
import 'package:life_weather_mobile/src/core/utils/spacing/v_space.dart';
import 'package:life_weather_mobile/src/core/widgets/common_widget.dart';
import 'package:life_weather_mobile/src/features/weather/presentation/bloc/bloc/weather_bloc.dart';
import 'package:life_weather_mobile/src/features/weather/presentation/body/current_weather_v2.dart';
import 'package:life_weather_mobile/src/features/weather/presentation/body/five_days_weather.dart';

class WeatherScreenV2 extends StatefulWidget {
  const WeatherScreenV2({super.key});

  static const String routeName = 'weather/v2';

  @override
  State<WeatherScreenV2> createState() => _WeatherScreenV2State();
}

class _WeatherScreenV2State extends State<WeatherScreenV2> {
  late final WeatherBloc weatherBloc;

  @override
  void initState() {
    setBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(
        context: context,
        elevation: 1,
        backgroundColor: ColorName.white,
        titleWidget: const Center(
          child: CustomText(
            text: 'Weather Forecast',
            style: TextStyle(color: Colors.black),
          ),
        ),
        showBackBtn: true,
      ),
      body: BlocConsumer<WeatherBloc, WeatherState>(
        bloc: weatherBloc,
        listener: (context, state) {
          if (state.viewStatus == ViewStatus.loading) {
            LoaderDialog.show(context: context);
          }

          if ((state.viewStatus == ViewStatus.failed ||
                  state.viewStatus == ViewStatus.successful) &&
              state.currentWeather == null) {
            LoaderDialog.hide(context: context);
          }
        },
        builder: (context, state) {
          final currentWeather = state.currentWeather;

          if (state.viewStatus == ViewStatus.successful &&
              currentWeather != null) {
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CurrentWeatherV2(
                      weather: currentWeather,
                    ),
                    Vspace.md,
                    Column(
                      children: state.fiveDaysWeather
                          .map((weather) => FiveDaysWeather(weather: weather))
                          .toList(),
                    )
                  ],
                ),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  void setBloc() {
    weatherBloc = BlocProvider.of<WeatherBloc>(context);
    weatherBloc.add(const GetCurrentWeatherEvent(
        latitude: 13.582336, longitude: 123.2928768));
  }
}
