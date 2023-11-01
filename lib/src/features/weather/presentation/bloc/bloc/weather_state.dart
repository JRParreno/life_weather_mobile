part of 'weather_bloc.dart';

class WeatherState extends Equatable {
  final List<Weather> fiveDaysWeather;
  final Weather? currentWeather;
  final ViewStatus viewStatus;

  const WeatherState({
    required this.fiveDaysWeather,
    this.currentWeather,
    this.viewStatus = ViewStatus.none,
  });

  @override
  List<Object?> get props => [
        fiveDaysWeather,
        currentWeather,
        viewStatus,
      ];

  factory WeatherState.empty() {
    return const WeatherState(currentWeather: null, fiveDaysWeather: []);
  }

  WeatherState copyWith({
    List<Weather>? fiveDaysWeather,
    Weather? currentWeather,
    ViewStatus? viewStatus,
  }) {
    return WeatherState(
      fiveDaysWeather: fiveDaysWeather ?? this.fiveDaysWeather,
      currentWeather: currentWeather ?? this.currentWeather,
      viewStatus: viewStatus ?? this.viewStatus,
    );
  }
}
