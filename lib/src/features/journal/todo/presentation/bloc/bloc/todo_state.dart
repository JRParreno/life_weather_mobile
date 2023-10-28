part of 'todo_bloc.dart';

class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object?> get props => [];
}

class TodoLoaded extends TodoState {
  final TodoResponseModel todoResponseModel;
  final ViewStatus viewStatus;

  const TodoLoaded({
    required this.todoResponseModel,
    this.viewStatus = ViewStatus.none,
  });

  @override
  List<Object?> get props => [
        todoResponseModel,
        viewStatus,
      ];

  TodoLoaded copyWith({
    TodoResponseModel? todoResponseModel,
    ViewStatus? viewStatus,
  }) {
    return TodoLoaded(
      todoResponseModel: todoResponseModel ?? this.todoResponseModel,
      viewStatus: viewStatus ?? this.viewStatus,
    );
  }
}
