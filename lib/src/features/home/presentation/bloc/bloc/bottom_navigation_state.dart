part of 'bottom_navigation_bloc.dart';

class BottomNavigationState extends Equatable {
  const BottomNavigationState({
    this.index = 0,
  });
  final int index;

  @override
  List<Object?> get props => [index];

  BottomNavigationState copyWith({
    int? index,
  }) {
    return BottomNavigationState(
      index: index ?? this.index,
    );
  }
}
