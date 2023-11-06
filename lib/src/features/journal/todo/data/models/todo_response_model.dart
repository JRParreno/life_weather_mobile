import 'dart:convert';

import 'package:life_weather_mobile/src/features/journal/todo/data/models/todo_model.dart';

class TodoResponseModel {
  const TodoResponseModel({
    required this.todos,
    required this.count,
    required this.hasNextPage,
    this.page = 1,
  });

  final List<TodoModel> todos;
  final int count;
  final bool hasNextPage;
  final int page;

  factory TodoResponseModel.empty() {
    return const TodoResponseModel(
      count: 0,
      hasNextPage: false,
      todos: [],
      page: -1,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'todos': todos.map((x) => x.toMap()).toList()});
    result.addAll({'count': count});
    result.addAll({'hasNextPage': hasNextPage});

    return result;
  }

  factory TodoResponseModel.fromMap(Map<String, dynamic> map) {
    return TodoResponseModel(
      todos:
          List<TodoModel>.from(map['todos']?.map((x) => TodoModel.fromMap(x))),
      count: map['count']?.toInt() ?? 0,
      hasNextPage: map['hasNextPage'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoResponseModel.fromJson(String source) =>
      TodoResponseModel.fromMap(json.decode(source));

  TodoResponseModel copyWith({
    List<TodoModel>? todos,
    int? count,
    bool? hasNextPage,
    int? page,
  }) {
    return TodoResponseModel(
      todos: todos ?? this.todos,
      count: count ?? this.count,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      page: page ?? this.page,
    );
  }
}
