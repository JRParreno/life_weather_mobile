import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:life_weather_mobile/src/core/bloc/view_status.dart';
import 'package:life_weather_mobile/src/core/config/app_constant.dart';
import 'package:weather/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherState.empty()) {
    on<GetCurrentWeatherEvent>(_getCurrentWeatherEvent);
  }

  Future<void> _getCurrentWeatherEvent(
      GetCurrentWeatherEvent event, Emitter<WeatherState> emit) async {
    final state = this.state;

    if (state.currentWeather == null) {
      emit(state.copyWith(viewStatus: ViewStatus.loading));

      try {
        final lat = event.latitude;
        final lng = event.longitude;

        final WeatherFactory wf = WeatherFactory(AppConstant.weatherApiKey);

        final List<Weather> wfDays =
            await wf.fiveDayForecastByLocation(lat, lng);

        final Weather currentWeather =
            await wf.currentWeatherByLocation(lat, lng);

        emit(
          state.copyWith(
            viewStatus: ViewStatus.successful,
          ),
        );

        return emit(
          state.copyWith(
            fiveDaysWeather: getDayInterval(wfDays),
            currentWeather: currentWeather,
            viewStatus: ViewStatus.successful,
          ),
        );
      } catch (e) {
        emit(state.copyWith(viewStatus: ViewStatus.failed));
      }
    }
  }

  List<Weather> getDayInterval(List<Weather> forecast) {
    final items = [0, 8, 16, 24, 32];

    return items.map((e) => forecast[e]).toList();
  }
}
