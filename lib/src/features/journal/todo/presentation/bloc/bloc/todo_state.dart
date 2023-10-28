part of 'todo_bloc.dart';

class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object?> get props => [];
}

class TodoLoaded extends TodoState {
  final TodoResponseModel todoResponseModel;
  final ViewStatus viewStatus;
  final bool isDeleteTodo;

  const TodoLoaded({
    required this.todoResponseModel,
    this.viewStatus = ViewStatus.none,
    this.isDeleteTodo = false,
  });

  @override
  List<Object?> get props => [
        todoResponseModel,
        viewStatus,
        isDeleteTodo,
      ];

  TodoLoaded copyWith({
    TodoResponseModel? todoResponseModel,
    ViewStatus? viewStatus,
    bool? isDeleteTodo,
  }) {
    return TodoLoaded(
      todoResponseModel: todoResponseModel ?? this.todoResponseModel,
      viewStatus: viewStatus ?? this.viewStatus,
      isDeleteTodo: isDeleteTodo ?? this.isDeleteTodo,
    );
  }
}
