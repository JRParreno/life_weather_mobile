import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_weather_mobile/gen/colors.gen.dart';
import 'package:life_weather_mobile/src/core/bloc/view_status.dart';
import 'package:life_weather_mobile/src/core/utils/spacing/v_space.dart';
import 'package:life_weather_mobile/src/core/widgets/common_widget.dart';
import 'package:life_weather_mobile/src/features/weather/presentation/bloc/bloc/weather_bloc.dart';
import 'package:life_weather_mobile/src/features/weather/presentation/body/current_weather.dart';
import 'package:life_weather_mobile/src/features/weather/presentation/body/hourly_weather.dart';
import 'package:life_weather_mobile/src/features/weather/presentation/weather_screen_v2.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  static const routeName = 'weather/';

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late final WeatherBloc weatherBloc;

  @override
  void initState() {
    setBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.gray,
      appBar: buildAppBar(
          context: context, title: 'Weather Forecast', showBackBtn: true),
      body: BlocConsumer<WeatherBloc, WeatherState>(
        listener: (context, state) {
          if (state.viewStatus == ViewStatus.loading) {
            LoaderDialog.show(context: context);
          }

          if (state.viewStatus == ViewStatus.failed ||
              state.viewStatus == ViewStatus.successful ||
              state.currentWeather != null) {
            LoaderDialog.hide(context: context);
          }
        },
        builder: (context, state) {
          if (state.viewStatus == ViewStatus.successful) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CurrentWeather(
                    currentWeather: state.currentWeather!,
                  ),
                  Vspace.lg,
                  HourlyWeather(
                    fwDays: state.fiveDaysWeather,
                  ),
                  Vspace.md,
                  CustomBtn(
                    label: 'test',
                    onTap: () {
                      Navigator.pushNamed(context, WeatherScreenV2.routeName);
                    },
                  )
                ],
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
