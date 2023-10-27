import 'package:equatable/equatable.dart';
import 'package:life_weather_mobile/src/core/bloc/profile/profile_bloc.dart';
import 'package:life_weather_mobile/src/features/journal/todo/presentation/bloc/bloc/todo_bloc.dart';

abstract class CommonEvent extends Equatable
    implements ProfileEvent, TodoEvent {
  const CommonEvent();

  @override
  List<Object> get props => [];
}

// initial state for all blocs
class InitialEvent extends CommonEvent {
  const InitialEvent();
}

class NoInternetConnectionEvent extends CommonEvent {
  const NoInternetConnectionEvent();
}
