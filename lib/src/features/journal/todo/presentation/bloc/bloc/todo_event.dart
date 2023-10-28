part of 'todo_bloc.dart';

class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object?> get props => [];
}

class TodoGetEventList extends TodoEvent {
  const TodoGetEventList();
}

class AddTodoEvent extends TodoEvent {
  final String title;
  final String note;
  final String status;

  const AddTodoEvent({
    required this.title,
    required this.note,
    required this.status,
  });

  @override
  List<Object?> get props => [
        title,
        note,
        status,
      ];
}

class UpdateTodoEvent extends TodoEvent {
  final String title;
  final String note;
  final String id;
  final String status;

  const UpdateTodoEvent({
    required this.title,
    required this.note,
    required this.id,
    required this.status,
  });

  @override
  List<Object?> get props => [
        title,
        note,
        id,
        status,
      ];
}

class DeleteTodoEvent extends TodoEvent {
  final String pk;

  const DeleteTodoEvent(this.pk);

  @override
  List<Object?> get props => [pk];
}
