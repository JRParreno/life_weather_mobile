part of 'weather_bloc.dart';

class WeatherState extends Equatable {
  final List<Weather> fiveDaysWeather;
  final Weather? currentWeather;
  final ViewStatus viewStatus;
  final bool isLocationEnable;

  const WeatherState({
    required this.fiveDaysWeather,
    this.currentWeather,
    this.viewStatus = ViewStatus.none,
    this.isLocationEnable = true,
  });

  @override
  List<Object?> get props => [
        fiveDaysWeather,
        currentWeather,
        viewStatus,
        isLocationEnable,
      ];

  factory WeatherState.empty() {
    return const WeatherState(currentWeather: null, fiveDaysWeather: []);
  }

  WeatherState copyWith({
    List<Weather>? fiveDaysWeather,
    Weather? currentWeather,
    ViewStatus? viewStatus,
    bool? isLocationEnable,
  }) {
    return WeatherState(
      fiveDaysWeather: fiveDaysWeather ?? this.fiveDaysWeather,
      currentWeather: currentWeather ?? this.currentWeather,
      viewStatus: viewStatus ?? this.viewStatus,
      isLocationEnable: isLocationEnable ?? this.isLocationEnable,
    );
  }
}
