import 'package:life_weather_mobile/src/features/journal/todo/data/models/todo_model.dart';
import 'package:life_weather_mobile/src/features/journal/todo/data/models/todo_response_model.dart';

abstract class TodoRepository {
  Future<TodoResponseModel> todoList();

  Future<TodoModel> addTodo({
    required String title,
    required String note,
    required String userPk,
  });

  Future<TodoModel> updatedTodo({
    required String pk,
    required String title,
    required String note,
    required String status,
  });

  Future<void> deleteTodo(String pk);
}
