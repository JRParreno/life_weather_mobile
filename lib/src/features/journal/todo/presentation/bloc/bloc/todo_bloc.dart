import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_weather_mobile/src/core/bloc/common/common_event.dart';
import 'package:life_weather_mobile/src/core/bloc/common/common_state.dart';
import 'package:life_weather_mobile/src/core/bloc/view_status.dart';
import 'package:life_weather_mobile/src/features/journal/todo/data/models/todo_response_model.dart';
import 'package:life_weather_mobile/src/features/journal/todo/domain/repositories/todo_repository.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository _repository;

  TodoBloc(this._repository) : super(const InitialState()) {
    on<InitialEvent>(_initialEvent);
    on<TodoGetEventList>(_todoGetEventList);
    on<AddTodoEvent>(_addTodoEvent);
    on<UpdateTodoEvent>(_updateTodoEvent);
  }

  void _initialEvent(InitialEvent event, Emitter<TodoState> emit) {
    return emit(const InitialState());
  }

  Future<void> _todoGetEventList(
      TodoGetEventList event, Emitter<TodoState> emit) async {
    emit(const LoadingState());
    try {
      final todoRes = await _repository.todoList();
      emit(TodoLoaded(
        todoResponseModel: todoRes,
      ));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  Future<void> _addTodoEvent(
      AddTodoEvent event, Emitter<TodoState> emit) async {
    final state = this.state;

    if (state is TodoLoaded) {
      emit(state.copyWith(viewStatus: ViewStatus.loading));

      try {
        final todoModelRes = await _repository.addTodo(
          note: event.note,
          title: event.title,
          status: event.status,
        );

        emit(
          state.copyWith(
            viewStatus: ViewStatus.successful,
          ),
        );

        emit(TodoLoaded(
          todoResponseModel: state.todoResponseModel.copyWith(
            todos: [todoModelRes, ...state.todoResponseModel.todos],
            count: state.todoResponseModel.count + 1,
          ),
        ));
      } catch (e) {
        emit(ErrorState(e.toString()));
        emit(state.copyWith(viewStatus: ViewStatus.loading));
      }
    }
  }

  Future<void> _updateTodoEvent(
      UpdateTodoEvent event, Emitter<TodoState> emit) async {
    final state = this.state;

    if (state is TodoLoaded) {
      emit(state.copyWith(viewStatus: ViewStatus.loading));

      try {
        final todoModelRes = await _repository.updatedTodo(
          note: event.note,
          title: event.title,
          status: event.status,
          pk: event.id,
        );

        emit(
          state.copyWith(
            viewStatus: ViewStatus.successful,
          ),
        );

        final currentTodos = [...state.todoResponseModel.todos];
        currentTodos.removeWhere(
          (element) => element.pk.toString() == event.id,
        );

        emit(TodoLoaded(
          todoResponseModel: state.todoResponseModel.copyWith(
            todos: [todoModelRes, ...currentTodos],
            count: state.todoResponseModel.count,
          ),
        ));
      } catch (e) {
        emit(ErrorState(e.toString()));
        emit(state.copyWith(viewStatus: ViewStatus.loading));
      }
    }
  }
}
