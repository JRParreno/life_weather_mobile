import 'package:life_weather_mobile/src/features/journal/todo/data/models/todo_model.dart';
import 'package:life_weather_mobile/src/features/journal/todo/data/models/todo_response_model.dart';

abstract class TodoRepository {
  Future<TodoResponseModel> todoList(int page);

  Future<TodoModel> addTodo({
    required String title,
    required String note,
    required String status,
  });

  Future<TodoModel> updatedTodo({
    required String pk,
    required String title,
    required String note,
    required String status,
  });

  Future<void> deleteTodo(String pk);
}
