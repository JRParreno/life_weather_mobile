import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_navigation_event.dart';
part 'bottom_navigation_state.dart';

class BottomNavigationBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  BottomNavigationBloc() : super(const BottomNavigationState(index: 0)) {
    on<UpdateBottomNavEvent>(_updateBottomNavEvent);
  }

  void _updateBottomNavEvent(
      UpdateBottomNavEvent event, Emitter<BottomNavigationState> emit) {
    emit(state.copyWith(index: event.index));
  }
}
