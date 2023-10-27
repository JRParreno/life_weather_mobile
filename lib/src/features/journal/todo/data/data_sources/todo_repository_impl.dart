import 'package:dio/dio.dart';
import 'package:life_weather_mobile/src/core/config/app_constant.dart';
import 'package:life_weather_mobile/src/core/interceptor/api_interceptor.dart';
import 'package:life_weather_mobile/src/features/journal/todo/data/models/todo_model.dart';
import 'package:life_weather_mobile/src/features/journal/todo/data/models/todo_response_model.dart';
import 'package:life_weather_mobile/src/features/journal/todo/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl extends TodoRepository {
  final Dio dio = Dio();
  static const String url = '${AppConstant.apiUrl}/todo/list';

  @override
  Future<TodoModel> addTodo({
    required String title,
    required String note,
    required String userPk,
  }) async {
    final data = {
      "user_profile": userPk,
      "title": title,
      "note": note,
    };

    return await ApiInterceptor.apiInstance()
        .post(url, data: data)
        .then((value) {
      return {'status': value.statusCode, 'data': value.data};
    }).then((value) {
      final response = value;

      return TodoModel.fromMap(response);
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }

  @override
  Future<void> deleteTodo(String pk) {
    // TODO: implement deleteTodo
    throw UnimplementedError();
  }

  @override
  Future<TodoResponseModel> todoList() async {
    return await ApiInterceptor.apiInstance().get(url).then((value) {
      final results = value.data['results'] as List<dynamic>;
      List<TodoModel> todos = [];

      if (results.isNotEmpty) {
        todos = results.map((e) => TodoModel.fromMap(e)).toList();
      }

      return TodoResponseModel(
          todos: todos,
          count: value.data['count'],
          hasNextPage: value.data['next'] != null);
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }

  @override
  Future<TodoModel> updatedTodo(
      {required String pk,
      required String title,
      required String note,
      required String status}) {
    // TODO: implement updatedTodo
    throw UnimplementedError();
  }
}
