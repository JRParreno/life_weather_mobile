part of 'bottom_navigation_bloc.dart';

class BottomNavigationEvent extends Equatable {
  const BottomNavigationEvent();

  @override
  List<Object?> get props => [];
}

class UpdateBottomNavEvent extends BottomNavigationEvent {
  const UpdateBottomNavEvent(this.index);

  final int index;

  @override
  List<Object?> get props => [index];
}

class ResetBottomNavEvent extends BottomNavigationEvent {}
