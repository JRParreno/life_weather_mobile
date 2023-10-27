import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_weather_mobile/src/core/bloc/common/common_event.dart';
import 'package:life_weather_mobile/src/core/bloc/common/common_state.dart';
import 'package:life_weather_mobile/src/features/journal/todo/data/models/todo_response_model.dart';
import 'package:life_weather_mobile/src/features/journal/todo/domain/repositories/todo_repository.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository _repository;

  TodoBloc(this._repository) : super(const InitialState()) {
    on<InitialEvent>(_initialEvent);
    on<TodoGetEventList>(_todoGetEventList);
  }

  void _initialEvent(InitialEvent event, Emitter<TodoState> emit) {
    return emit(const InitialState());
  }

  Future<void> _todoGetEventList(
      TodoGetEventList event, Emitter<TodoState> emit) async {
    emit(const LoadingState());
    try {
      final todoRes = await _repository.todoList();
      emit(TodoLoaded(todoRes));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
