part of 'todo_bloc.dart';

class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object?> get props => [];
}

class TodoLoaded extends TodoState {
  final TodoResponseModel todoResponseModel;

  const TodoLoaded(this.todoResponseModel);

  @override
  List<Object?> get props => [todoResponseModel];
}
